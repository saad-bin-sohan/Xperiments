/// Severity level for a diagnostic log entry.
///
/// Named [LogLevel] to avoid clashing with Flutter's built-in
/// [DiagnosticLevel] from `package:flutter/foundation.dart`.
enum LogLevel {
  info,
  warning,
  error,
  fatal;

  String get label {
    switch (this) {
      case LogLevel.info:
        return 'INFO';
      case LogLevel.warning:
        return 'WARN';
      case LogLevel.error:
        return 'ERROR';
      case LogLevel.fatal:
        return 'FATAL';
    }
  }
}

/// A single diagnostic log entry captured at runtime.
class DiagnosticLog {
  const DiagnosticLog({
    required this.timestamp,
    required this.level,
    required this.source,
    required this.message,
    this.stackTrace,
  });

  final DateTime timestamp;
  final LogLevel level;

  /// Where the error originated, e.g. "Firestore", "Flutter", "Zone",
  /// "Provider".
  final String source;
  final String message;
  final String? stackTrace;

  String format() {
    final buffer = StringBuffer()
      ..writeln(
        '[${timestamp.toIso8601String()}] ${level.label} ($source)',
      )
      ..writeln(message);

    if (stackTrace != null && stackTrace!.isNotEmpty) {
      buffer.writeln(stackTrace);
    }

    return buffer.toString();
  }
}
