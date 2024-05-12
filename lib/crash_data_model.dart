import 'package:quash_watch/quash_crash_watch.dart';

class CrashData {
  final DateTime timestamp;
  final String errorType;
  final Severity severity;

  CrashData(this.timestamp, this.errorType, this.severity);

  factory CrashData.fromJson(Map<String, dynamic> json) {
    return CrashData(
      DateTime.parse(json['timestamp']),
      json['errorType'] as String,
      Severity.values[json['severity'] as int],
    );
  }
}

class LogEntry {
  final String message;
  final DateTime timeStamp;
  final Severity severity;

  LogEntry(this.message, this.timeStamp, this.severity);

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'timeStamp': timeStamp.toIso8601String(),
      'severity': severity.toString().split('.').last,
    };
  }

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    try {
      return LogEntry(
        json['message'] ?? '',
        DateTime.parse(json['timeStamp'] ?? ''),
        Severity.values.firstWhere(
          (severity) => severity.toString().split('.').last == json['severity'],
          orElse: () => Severity.high,
        ),
      );
    } catch (e) {
      print('Error parsing log entry JSON: $e');
      // Return a default LogEntry or handle the error as needed
      return LogEntry('', DateTime.now(), Severity.high);
    }
  }
}
