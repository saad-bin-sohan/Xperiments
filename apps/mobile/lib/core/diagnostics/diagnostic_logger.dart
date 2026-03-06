import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
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
  static const String _logFileName = 'xperiments_diagnostics.txt';

  final Queue<DiagnosticLog> _logs = Queue<DiagnosticLog>();
  File? _logFile;
  bool _initialized = false;
  Future<void> _pendingWrite = Future<void>.value();

  /// Returns an unmodifiable view of all captured logs (newest first).
  List<DiagnosticLog> get logs => _logs.toList().reversed.toList();

  /// Number of entries currently stored.
  int get count => _logs.length;

  /// Initializes the persistent diagnostics file.
  Future<void> initialize() async {
    if (!kDebugMode || _initialized) {
      return;
    }

    try {
      await _resolveLogFile();
      _initialized = true;
    } catch (error, stackTrace) {
      debugPrint('[DIAG] Failed to initialize diagnostic file: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  /// Returns the stable rolling diagnostics file.
  Future<File> getLogFile() async {
    if (!kDebugMode) {
      throw StateError('Diagnostics file is available only in debug mode.');
    }

    return _resolveLogFile();
  }

  /// Returns the diagnostics file after all queued writes have completed.
  Future<File> getLogFileForExport() async {
    await _waitForPendingWrites();
    return getLogFile();
  }

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

    _appendEntryToFile(entry);

    // Also print to console for convenience.
    debugPrint('[DIAG] ${entry.format()}');

    // Defer UI notification to avoid setState-during-frame errors when
    // log() is called from FlutterError.onError during a paint frame.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  /// Convenient shorthand for [LogLevel.error].
  void logError(String source, Object error, [StackTrace? stackTrace]) {
    log(LogLevel.error, source, error.toString(), stackTrace);
  }

  /// Clear all stored entries and the persisted diagnostics file.
  Future<void> clear() async {
    _logs.clear();
    notifyListeners();

    if (!kDebugMode) {
      return;
    }

    await _waitForPendingWrites();
    final file = await getLogFile();
    await file.writeAsString('', flush: true);
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

    String? persistedContent;
    if (kDebugMode) {
      await _waitForPendingWrites();
      try {
        final file = await getLogFile();
        persistedContent = await file.readAsString();
      } catch (error, stackTrace) {
        debugPrint('[DIAG] Failed to read diagnostic file for export: $error');
        debugPrintStack(stackTrace: stackTrace);
      }
    }

    final hasPersistedContent =
        persistedContent != null && persistedContent.trim().isNotEmpty;
    if (hasPersistedContent) {
      buffer.writeln('Entries source: persisted file');
      buffer.writeln('========================================');
      buffer.writeln();
      buffer.write(persistedContent);
      if (!persistedContent.endsWith('\n')) {
        buffer.writeln();
      }
      return buffer.toString();
    }

    buffer.writeln('Entries source: in-memory fallback');
    buffer.writeln('Entries: ${_logs.length}');
    buffer.writeln('========================================');
    buffer.writeln();

    for (final entry in _logs) {
      buffer.writeln(entry.format());
    }

    return buffer.toString();
  }

  void _appendEntryToFile(DiagnosticLog entry) {
    final payload = StringBuffer()
      ..write(entry.format())
      ..writeln('----------------------------------------');

    _pendingWrite = _pendingWrite.then((_) async {
      try {
        final file = await getLogFile();
        await file.writeAsString(
          payload.toString(),
          mode: FileMode.append,
          flush: true,
        );
      } catch (error, stackTrace) {
        debugPrint('[DIAG] Failed to persist diagnostic log: $error');
        debugPrintStack(stackTrace: stackTrace);
      }
    });
  }

  Future<void> _waitForPendingWrites() async {
    await _pendingWrite;
  }

  Future<File> _resolveLogFile() async {
    if (_logFile != null) {
      return _logFile!;
    }

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$_logFileName');
    if (!await file.exists()) {
      await file.create(recursive: true);
    }

    _logFile = file;
    return file;
  }
}
