import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/utils/date_utils.dart';
import 'package:mobile/core/widgets/app_async_view.dart';
import 'package:mobile/core/widgets/app_empty_state.dart';
import 'package:mobile/features/journal/domain/entities/journal_entry.dart';
import 'package:mobile/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mobile/features/journal/presentation/providers/journal_providers.dart';

class LabJournalSection extends ConsumerStatefulWidget {
  const LabJournalSection({super.key, required this.labId});

  final String labId;

  @override
  ConsumerState<LabJournalSection> createState() => _LabJournalSectionState();
}

class _LabJournalSectionState extends ConsumerState<LabJournalSection> {
  late final TextEditingController _searchController;
  Timer? _debounce;
  String _query = '';

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
    ref.listen<AsyncValue<void>>(journalControllerProvider, (_, next) {
      next.whenOrNull(
        error: (Object error, StackTrace _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Journal',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _openEditor(context),
                  icon: const Icon(Icons.add),
                  label: const Text('New Entry'),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingSm),
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search journal entries',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
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
            const SizedBox(height: AppSizes.spacingSm),
            if (_query.isEmpty)
              AppAsyncView<List<JournalEntry>>(
                value: ref.watch(labJournalEntriesProvider(widget.labId)),
                data: _entriesList,
              )
            else
              AppAsyncView<List<JournalEntry>>(
                value: ref.watch(
                  labJournalSearchProvider(labId: widget.labId, query: _query),
                ),
                data: _entriesList,
              ),
          ],
        ),
      ),
    );
  }

  Widget _entriesList(List<JournalEntry> entries) {
    if (entries.isEmpty) {
      return const SizedBox(
        height: 160,
        child: AppEmptyState(
          title: 'No journal entries',
          message: 'Write notes here when this lab journal is enabled.',
          icon: Icons.menu_book_outlined,
        ),
      );
    }

    return Column(
      children: entries.map((entry) {
        return Card(
          margin: const EdgeInsets.only(bottom: AppSizes.spacingSm),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spacingSm,
              vertical: AppSizes.spacingXs,
            ),
            title: Text(AppDateUtils.formatDate(entry.date)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if ((entry.moodWords ?? '').isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(entry.moodWords!),
                  ),
                const SizedBox(height: 2),
                Text(entry.body, maxLines: 3, overflow: TextOverflow.ellipsis),
              ],
            ),
            trailing: Wrap(
              spacing: 0,
              children: <Widget>[
                IconButton(
                  onPressed: () => _openEditor(context, existing: entry),
                  icon: const Icon(Icons.edit_outlined),
                ),
                IconButton(
                  onPressed: () => _deleteEntry(context, entry),
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 180), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _query = value.trim();
      });
    });
  }

  Future<void> _openEditor(
    BuildContext context, {
    JournalEntry? existing,
  }) async {
    final moodController = TextEditingController(
      text: existing?.moodWords ?? '',
    );
    final bodyController = TextEditingController(text: existing?.body ?? '');
    var selectedDate =
        existing?.date ?? AppDateUtils.startOfDay(DateTime.now());

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: AppSizes.spacingMd,
            right: AppSizes.spacingMd,
            top: AppSizes.spacingMd,
            bottom:
                MediaQuery.of(sheetContext).viewInsets.bottom +
                AppSizes.spacingMd,
          ),
          child: StatefulBuilder(
            builder: (context, setLocalState) {
              final isBusy = ref.watch(journalControllerProvider).isLoading;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    existing == null
                        ? 'New Journal Entry'
                        : 'Edit Journal Entry',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSizes.spacingSm),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Date'),
                    subtitle: Text(AppDateUtils.formatDate(selectedDate)),
                    trailing: const Icon(Icons.calendar_today_outlined),
                    onTap: isBusy
                        ? null
                        : () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setLocalState(() {
                                selectedDate = AppDateUtils.startOfDay(picked);
                              });
                            }
                          },
                  ),
                  TextField(
                    controller: moodController,
                    decoration: const InputDecoration(
                      labelText: 'Mood words (optional)',
                      hintText: 'focused, calm, tired',
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingSm),
                  TextField(
                    controller: bodyController,
                    minLines: 4,
                    maxLines: 10,
                    decoration: const InputDecoration(labelText: 'Entry'),
                  ),
                  const SizedBox(height: AppSizes.spacingMd),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: isBusy
                          ? null
                          : () async {
                              final navigator = Navigator.of(sheetContext);
                              final body = bodyController.text.trim();
                              if (body.isEmpty) {
                                return;
                              }

                              await ref
                                  .read(journalControllerProvider.notifier)
                                  .saveEntry(
                                    labId: widget.labId,
                                    entryId: existing?.id,
                                    date: selectedDate,
                                    moodWords: moodController.text.trim(),
                                    body: body,
                                  );

                              if (!mounted) {
                                return;
                              }

                              final state = ref.read(journalControllerProvider);
                              if (!state.hasError) {
                                navigator.pop();
                              }
                            },
                      child: Text(
                        existing == null ? 'Save Entry' : 'Save Changes',
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );

    moodController.dispose();
    bodyController.dispose();
  }

  Future<void> _deleteEntry(BuildContext context, JournalEntry entry) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete journal entry'),
          content: const Text('Delete this journal entry?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    await ref
        .read(journalControllerProvider.notifier)
        .deleteEntry(labId: widget.labId, entryId: entry.id);
  }
}
