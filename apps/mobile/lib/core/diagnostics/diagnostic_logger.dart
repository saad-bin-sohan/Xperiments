import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mobile/core/diagnostics/diagnostic_log.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

/// In-memory ring-buffer logger that captures diagnostic events.
///
/// Only records entries when [kDebugMode] is `true` so there is zero runtime
/// cost in release builds.
class DiagnosticLogger extends ChangeNotifier {
  DiagnosticLogger._();

  static final DiagnosticLogger instance = DiagnosticLogger._();

  /// Maximum number of log entries kept in memory.
  static const int maxEntries = 500;

  final Queue<DiagnosticLog> _logs = Queue<DiagnosticLog>();

  /// Returns an unmodifiable view of all captured logs (newest first).
  List<DiagnosticLog> get logs => _logs.toList().reversed.toList();

  /// Number of entries currently stored.
  int get count => _logs.length;

  /// Records a diagnostic entry. No-op in release builds.
  void log(
    LogLevel level,
    String source,
    String message, [
    StackTrace? stackTrace,
  ]) {
    if (!kDebugMode) {
      return;
    }

    final entry = DiagnosticLog(
      timestamp: DateTime.now(),
      level: level,
      source: source,
      message: message,
      stackTrace: stackTrace?.toString(),
    );

    _logs.addLast(entry);

    while (_logs.length > maxEntries) {
      _logs.removeFirst();
    }

    // Also print to console for convenience.
    debugPrint('[DIAG] ${entry.format()}');

    notifyListeners();
  }

  /// Convenient shorthand for [LogLevel.error].
  void logError(String source, Object error, [StackTrace? stackTrace]) {
    log(LogLevel.error, source, error.toString(), stackTrace);
  }

  /// Clear all stored entries.
  void clear() {
    _logs.clear();
    notifyListeners();
  }

  /// Formats all logs into a shareable plain-text report.
  Future<String> export() async {
    final buffer = StringBuffer();

    buffer.writeln('=== Xperiments Diagnostic Report ===');
    buffer.writeln('Generated: ${DateTime.now().toIso8601String()}');

    try {
      final info = await PackageInfo.fromPlatform();
      buffer.writeln(
        'App: ${info.appName} ${info.version}+${info.buildNumber}',
      );
    } catch (_) {
      buffer.writeln('App: (unable to read package info)');
    }

    buffer.writeln(
      'Platform: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
    );
    buffer.writeln('Dart: ${Platform.version}');
    buffer.writeln('Entries: ${_logs.length}');
    buffer.writeln('========================================');
    buffer.writeln();

    for (final entry in _logs) {
      buffer.writeln(entry.format());
    }

    return buffer.toString();
  }

  /// Exports logs to a temporary file and returns its path.
  Future<String> exportToFile() async {
    final content = await export();
    final dir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${dir.path}/xperiments_diag_$timestamp.txt');
    await file.writeAsString(content);
    return file.path;
  }
}
