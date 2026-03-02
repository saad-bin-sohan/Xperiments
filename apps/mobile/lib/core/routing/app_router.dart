import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/routing/route_paths.dart';
import 'package:mobile/core/routing/shell_scaffold.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/auth/presentation/screens/auth_screen.dart';
import 'package:mobile/features/checkin/presentation/screens/checkin_screen.dart';
import 'package:mobile/features/experiments/presentation/models/experiment_form_prefill.dart';
import 'package:mobile/features/experiments/presentation/screens/experiment_detail_screen.dart';
import 'package:mobile/features/experiments/presentation/screens/experiment_form_screen.dart';
import 'package:mobile/features/experiments/presentation/screens/experiments_tab_screen.dart';
import 'package:mobile/features/gallery/presentation/screens/gallery_tab_screen.dart';
import 'package:mobile/features/gallery/presentation/screens/gallery_template_screen.dart';
import 'package:mobile/features/history/presentation/screens/history_experiment_detail_screen.dart';
import 'package:mobile/features/history/presentation/screens/history_tab_screen.dart';
import 'package:mobile/features/labs/presentation/screens/lab_detail_screen.dart';
import 'package:mobile/features/labs/presentation/screens/lab_form_screen.dart';
import 'package:mobile/features/profile/presentation/screens/profile_settings_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: RoutePaths.experiments,
    refreshListenable: GoRouterRefreshStream(authRepository.observeAuthState()),
    redirect: (BuildContext context, GoRouterState state) {
      final signedIn = authRepository.isSignedIn;
      final isAuthRoute = state.matchedLocation == RoutePaths.auth;

      if (!signedIn && !isAuthRoute) {
        return RoutePaths.auth;
      }

      if (signedIn && isAuthRoute) {
        return RoutePaths.experiments;
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: RoutePaths.auth,
        builder: (BuildContext context, GoRouterState state) {
          return const AuthScreen();
        },
      ),
      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              return ShellScaffold(navigationShell: navigationShell);
            },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RoutePaths.experiments,
                builder: (BuildContext context, GoRouterState state) {
                  return const ExperimentsTabScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RoutePaths.history,
                builder: (BuildContext context, GoRouterState state) {
                  return const HistoryTabScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RoutePaths.gallery,
                builder: (BuildContext context, GoRouterState state) {
                  return const GalleryTabScreen();
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.profile,
        builder: (BuildContext context, GoRouterState state) {
          return const ProfileSettingsScreen();
        },
      ),
      GoRoute(
        path: RoutePaths.labsNew,
        builder: (BuildContext context, GoRouterState state) {
          return const LabFormScreen();
        },
      ),
      GoRoute(
        path: RoutePaths.labDetailPattern,
        builder: (BuildContext context, GoRouterState state) {
          final labId = state.pathParameters['labId']!;
          return LabDetailScreen(labId: labId);
        },
      ),
      GoRoute(
        path: RoutePaths.labEditPattern,
        builder: (BuildContext context, GoRouterState state) {
          final labId = state.pathParameters['labId']!;
          return LabFormScreen(labId: labId);
        },
      ),
      GoRoute(
        path: RoutePaths.experimentNewPattern,
        builder: (BuildContext context, GoRouterState state) {
          final labId = state.pathParameters['labId']!;
          return ExperimentFormScreen(
            initialLabId: labId,
            prefill: state.extra is ExperimentFormPrefill
                ? state.extra! as ExperimentFormPrefill
                : null,
          );
        },
      ),
      GoRoute(
        path: RoutePaths.experimentDetailPattern,
        builder: (BuildContext context, GoRouterState state) {
          final experimentId = state.pathParameters['experimentId']!;
          return ExperimentDetailScreen(experimentId: experimentId);
        },
      ),
      GoRoute(
        path: RoutePaths.experimentCheckinPattern,
        builder: (BuildContext context, GoRouterState state) {
          final experimentId = state.pathParameters['experimentId']!;
          final dateParam = state.uri.queryParameters['date'];
          final date = dateParam == null
              ? DateTime.now()
              : DateTime.tryParse(dateParam) ?? DateTime.now();

          return CheckinScreen(experimentId: experimentId, date: date);
        },
      ),
      GoRoute(
        path: RoutePaths.historyExperimentDetailPattern,
        builder: (BuildContext context, GoRouterState state) {
          final experimentId = state.pathParameters['experimentId']!;
          return HistoryExperimentDetailScreen(experimentId: experimentId);
        },
      ),
      GoRoute(
        path: RoutePaths.galleryTemplatePattern,
        builder: (BuildContext context, GoRouterState state) {
          final templateId = state.pathParameters['templateId']!;
          return GalleryTemplateScreen(templateId: templateId);
        },
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<Object?> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((Object? _) {
      notifyListeners();
    });
  }

  late final StreamSubscription<Object?> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
