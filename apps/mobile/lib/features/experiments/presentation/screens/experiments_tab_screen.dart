import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/constants/app_strings.dart';
import 'package:mobile/core/widgets/app_async_view.dart';
import 'package:mobile/core/widgets/app_empty_state.dart';
import 'package:mobile/core/widgets/app_error_state.dart';
import 'package:mobile/features/auth/presentation/controllers/auth_gate_controller.dart';
import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/presentation/providers/labs_providers.dart';

class ExperimentsTabScreen extends ConsumerWidget {
  const ExperimentsTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrap = ref.watch(authGateBootstrapProvider);

    return bootstrap.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, StackTrace stackTrace) {
        return AppErrorState(message: error.toString());
      },
      data: (_) {
        final labsAsync = ref.watch(currentUserLabsProvider);
        return AppAsyncView<List<Lab>>(
          value: labsAsync,
          data: (List<Lab> labs) {
            return ListView(
              padding: const EdgeInsets.all(AppSizes.spacingMd),
              children: <Widget>[
                _TodayCard(),
                const SizedBox(height: AppSizes.spacingMd),
                Text('Labs', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSizes.spacingSm),
                if (labs.isEmpty)
                  const SizedBox(
                    height: 220,
                    child: AppEmptyState(
                      title: 'No labs yet',
                      message: 'Your first lab will appear here.',
                      icon: Icons.science_outlined,
                    ),
                  )
                else
                  ...labs.map((Lab lab) => _LabCard(lab: lab)),
              ],
            );
          },
        );
      },
    );
  }
}

class _TodayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Today', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSizes.spacingSm),
            const Text(AppStrings.nothingDueToday),
          ],
        ),
      ),
    );
  }
}

class _LabCard extends StatelessWidget {
  const _LabCard({required this.lab});

  final Lab lab;

  @override
  Widget build(BuildContext context) {
    final Color color = _parseColor(lab.colorHex);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingSm),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(_iconForId(lab.iconId), color: Colors.white),
        ),
        title: Text(lab.name),
        subtitle: const Text('Total experiments: 0 · Completed: 0'),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Lab detail screen arrives in Phase 2.'),
            ),
          );
        },
      ),
    );
  }

  IconData _iconForId(String id) {
    switch (id) {
      case 'health':
        return Icons.favorite_outline;
      case 'finance':
        return Icons.savings_outlined;
      case 'mind':
        return Icons.psychology_outlined;
      case 'relationships':
        return Icons.people_outline;
      case 'lab_flask':
      default:
        return Icons.science_outlined;
    }
  }

  Color _parseColor(String hex) {
    final cleaned = hex.replaceAll('#', '');
    if (cleaned.length != 6) {
      return const Color(0xFF8E8E93);
    }
    return Color(int.parse('FF$cleaned', radix: 16));
  }
}
