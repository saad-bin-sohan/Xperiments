import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/core/diagnostics/diagnostic_log.dart';
import 'package:mobile/core/diagnostics/diagnostic_logger.dart';

/// Full-screen log viewer available only in debug builds.
class DiagnosticsScreen extends StatelessWidget {
  const DiagnosticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnostics'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _copyLogs(context),
            icon: const Icon(Icons.copy),
            tooltip: 'Copy to clipboard',
          ),
          IconButton(
            onPressed: () => _shareLogs(context),
            icon: const Icon(Icons.share),
            tooltip: 'Export logs',
          ),
          IconButton(
            onPressed: () {
              DiagnosticLogger.instance.clear();
            },
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear logs',
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: DiagnosticLogger.instance,
        builder: (BuildContext context, Widget? child) {
          final logs = DiagnosticLogger.instance.logs;

          if (logs.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.check_circle_outline,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No diagnostic logs yet',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Errors and warnings will appear here',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: logs.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (BuildContext context, int index) {
              final log = logs[index];
              return _LogTile(log: log);
            },
          );
        },
      ),
    );
  }

  Future<void> _copyLogs(BuildContext context) async {
    final report = await DiagnosticLogger.instance.export();
    await Clipboard.setData(ClipboardData(text: report));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logs copied to clipboard')),
      );
    }
  }

  Future<void> _shareLogs(BuildContext context) async {
    final filePath = await DiagnosticLogger.instance.exportToFile();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logs exported to: $filePath'),
          action: SnackBarAction(
            label: 'Copy path',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: filePath));
            },
          ),
        ),
      );
    }
  }
}

class _LogTile extends StatelessWidget {
  const _LogTile({required this.log});

  final DiagnosticLog log;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: _levelIcon(log.level),
      title: Text(
        log.message,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodySmall?.copyWith(
          color: _levelColor(log.level),
        ),
      ),
      subtitle: Text(
        '${_timeString(log.timestamp)}  ·  ${log.source}',
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.outline,
        ),
      ),
      children: <Widget>[
        if (log.stackTrace != null && log.stackTrace!.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: theme.colorScheme.surfaceContainerHighest,
            child: SelectableText(
              log.stackTrace!,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
                fontSize: 10,
              ),
            ),
          ),
      ],
    );
  }

  Widget _levelIcon(LogLevel level) {
    switch (level) {
      case LogLevel.info:
        return const Icon(Icons.info_outline, color: Colors.blue, size: 18);
      case LogLevel.warning:
        return const Icon(Icons.warning_amber, color: Colors.orange, size: 18);
      case LogLevel.error:
        return const Icon(Icons.error_outline, color: Colors.red, size: 18);
      case LogLevel.fatal:
        return const Icon(Icons.dangerous, color: Colors.red, size: 18);
    }
  }

  Color _levelColor(LogLevel level) {
    switch (level) {
      case LogLevel.info:
        return Colors.blue;
      case LogLevel.warning:
        return Colors.orange;
      case LogLevel.error:
      case LogLevel.fatal:
        return Colors.red;
    }
  }

  String _timeString(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}'
        ':${dt.minute.toString().padLeft(2, '0')}'
        ':${dt.second.toString().padLeft(2, '0')}';
  }
}
