import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/routing/route_paths.dart';
import 'package:mobile/core/utils/date_utils.dart';
import 'package:mobile/core/widgets/app_async_view.dart';
import 'package:mobile/core/widgets/app_empty_state.dart';
import 'package:mobile/core/widgets/app_error_state.dart';
import 'package:mobile/features/auth/presentation/controllers/auth_gate_controller.dart';
import 'package:mobile/features/history/domain/entities/history_experiment_group.dart';
import 'package:mobile/features/history/domain/entities/history_experiment_item.dart';
import 'package:mobile/features/history/domain/entities/history_search_result.dart';
import 'package:mobile/features/history/presentation/providers/history_providers.dart';

class HistoryTabScreen extends ConsumerStatefulWidget {
  const HistoryTabScreen({super.key});

  @override
  ConsumerState<HistoryTabScreen> createState() => _HistoryTabScreenState();
}

class _HistoryTabScreenState extends ConsumerState<HistoryTabScreen> {
  late final TextEditingController _searchController;
  Timer? _debounce;
  String _activeQuery = '';
  final Map<String, bool> _expandedByLab = <String, bool>{};

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bootstrap = ref.watch(authGateBootstrapProvider);

    return bootstrap.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, StackTrace _) {
        return AppErrorState(message: error.toString());
      },
      data: (_) {
        final groupsAsync = ref.watch(historyGroupsProvider);

        return ListView(
          padding: const EdgeInsets.all(AppSizes.spacingMd),
          children: <Widget>[
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search experiments, notes, reflections, lessons',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _activeQuery.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                        icon: const Icon(Icons.close),
                      ),
              ),
            ),
            const SizedBox(height: AppSizes.spacingMd),
            if (_activeQuery.isNotEmpty)
              _SearchResults(query: _activeQuery)
            else
              AppAsyncView<List<HistoryExperimentGroup>>(
                value: groupsAsync,
                data: _buildGroupedHistory,
              ),
          ],
        );
      },
    );
  }

  Widget _buildGroupedHistory(List<HistoryExperimentGroup> groups) {
    if (groups.isEmpty) {
      return const SizedBox(
        height: 260,
        child: AppEmptyState(
          title: 'No completed experiments',
          message: 'Completed and ended experiments will appear here.',
          icon: Icons.history,
        ),
      );
    }

    for (final group in groups) {
      _expandedByLab.putIfAbsent(group.labId, () => true);
    }

    return Column(
      children: groups.map((group) {
        final expanded = _expandedByLab[group.labId] ?? true;

        return Card(
          margin: const EdgeInsets.only(bottom: AppSizes.spacingSm),
          child: ExpansionTile(
            key: PageStorageKey<String>('history-${group.labId}'),
            initiallyExpanded: expanded,
            onExpansionChanged: (value) {
              setState(() {
                _expandedByLab[group.labId] = value;
              });
            },
            title: Text(group.labName),
            subtitle: Text('${group.items.length} experiment(s)'),
            children: group.items.map(_historyItemTile).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _historyItemTile(HistoryExperimentItem item) {
    final experiment = item.experiment;

    return ListTile(
      title: Text(experiment.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${AppDateUtils.formatDate(experiment.startDate)}'
            ' → ${experiment.completedAt != null ? AppDateUtils.formatDate(experiment.completedAt!) : '-'}',
          ),
          Text(
            'Completion ${item.completionPercent.toStringAsFixed(1)}%'
            '${experiment.passFailResult != null ? ' · ${experiment.passFailResult!.label}' : ''}',
          ),
          if ((experiment.finalReflection ?? '').isNotEmpty)
            Text(
              experiment.finalReflection!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        context.push(RoutePaths.historyExperimentDetail(experiment.id));
      },
    );
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 220), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _activeQuery = value.trim();
      });
    });
  }
}

class _SearchResults extends ConsumerWidget {
  const _SearchResults({required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync = ref.watch(historySearchProvider(query));

    return AppAsyncView<List<HistorySearchResult>>(
      value: resultsAsync,
      data: (results) {
        if (results.isEmpty) {
          return const SizedBox(
            height: 220,
            child: AppEmptyState(
              title: 'No results',
              message: 'No matches found for this search.',
              icon: Icons.search_off,
            ),
          );
        }

        return Column(
          children: results.map((result) {
            return Card(
              margin: const EdgeInsets.only(bottom: AppSizes.spacingSm),
              child: ListTile(
                title: Text(result.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_sourceLabel(result.sourceType)),
                    const SizedBox(height: 2),
                    Text(
                      result.snippet,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                trailing: result.experimentId.isEmpty
                    ? null
                    : const Icon(Icons.chevron_right),
                onTap: result.experimentId.isEmpty
                    ? null
                    : () {
                        context.push(
                          RoutePaths.historyExperimentDetail(
                            result.experimentId,
                          ),
                        );
                      },
              ),
            );
          }).toList(),
        );
      },
    );
  }

  String _sourceLabel(HistorySourceType type) {
    switch (type) {
      case HistorySourceType.experimentName:
        return 'Experiment name';
      case HistorySourceType.finalReflection:
        return 'Final reflection';
      case HistorySourceType.lessonsLearned:
        return 'Lessons learned';
      case HistorySourceType.checkinNote:
        return 'Check-in note';
      case HistorySourceType.journalEntry:
        return 'Journal entry';
    }
  }
}
