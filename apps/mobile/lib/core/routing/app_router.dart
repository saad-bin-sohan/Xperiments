import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/routing/route_paths.dart';
import 'package:mobile/core/routing/shell_scaffold.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/auth/presentation/screens/auth_screen.dart';
import 'package:mobile/features/experiments/presentation/screens/experiments_tab_screen.dart';
import 'package:mobile/features/gallery/presentation/screens/gallery_tab_screen.dart';
import 'package:mobile/features/history/presentation/screens/history_tab_screen.dart';
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
      final bool signedIn = authRepository.isSignedIn;
      final bool isAuthRoute = state.matchedLocation == RoutePaths.auth;

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
