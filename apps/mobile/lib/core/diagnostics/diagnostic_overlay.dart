import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/diagnostics/diagnostic_log.dart';
import 'package:mobile/core/diagnostics/diagnostic_logger.dart';
import 'package:mobile/core/diagnostics/diagnostics_screen.dart';

/// Injects a small floating debug button in the bottom-right corner of the
/// screen. Only renders in debug builds.
///
/// Usage – wrap around the child in [MaterialApp.builder]:
/// ```dart
/// MaterialApp.router(
///   builder: (context, child) => DiagnosticOverlay(child: child!),
/// );
/// ```
class DiagnosticOverlay extends StatelessWidget {
  const DiagnosticOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return child;
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: <Widget>[
          child,
          Positioned(
            right: 12,
            bottom: 100,
            child: _DebugFab(),
          ),
        ],
      ),
    );
  }
}

class _DebugFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: DiagnosticLogger.instance,
      builder: (BuildContext context, Widget? child) {
        final count = DiagnosticLogger.instance.count;
        final hasErrors = DiagnosticLogger.instance.logs.any(
          (DiagnosticLog log) =>
              log.level == LogLevel.error || log.level == LogLevel.fatal,
        );

        return SizedBox(
          width: 48,
          height: 48,
          child: FloatingActionButton(
            heroTag: '__diagnostic_fab__',
            mini: true,
            backgroundColor:
                hasErrors ? Colors.red.shade700 : Colors.grey.shade800,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute<void>(
                  builder: (_) => const DiagnosticsScreen(),
                ),
              );
            },
            child: Badge(
              isLabelVisible: count > 0,
              label: Text(
                count > 99 ? '99+' : count.toString(),
                style: const TextStyle(fontSize: 10),
              ),
              child: const Icon(
                Icons.bug_report,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
