import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/widgets/app_empty_state.dart';
import 'package:mobile/core/widgets/app_error_state.dart';
import 'package:mobile/features/auth/presentation/controllers/auth_gate_controller.dart';

class HistoryTabScreen extends ConsumerWidget {
  const HistoryTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrap = ref.watch(authGateBootstrapProvider);

    return bootstrap.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, StackTrace stackTrace) {
        return AppErrorState(message: error.toString());
      },
      data: (_) {
        return const AppEmptyState(
          title: 'No completed experiments',
          message: 'Completed and ended experiments will appear here.',
          icon: Icons.history,
        );
      },
    );
  }
}
