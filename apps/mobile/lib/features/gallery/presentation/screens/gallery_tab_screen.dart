import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/widgets/app_empty_state.dart';
import 'package:mobile/core/widgets/app_error_state.dart';
import 'package:mobile/features/auth/presentation/controllers/auth_gate_controller.dart';

class GalleryTabScreen extends ConsumerWidget {
  const GalleryTabScreen({super.key});

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
          title: 'Gallery is empty',
          message: 'Experiment templates from Firestore will appear here.',
          icon: Icons.photo_library_outlined,
        );
      },
    );
  }
}
