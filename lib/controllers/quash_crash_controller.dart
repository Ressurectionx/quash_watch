import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:quash_watch/models/log_entry_model.dart';
import 'package:quash_watch/utils/quash_utils.dart';

class QuashCrashWatch {
  static final ErrorLogger _errorLogger = ErrorLogger();

  static Future<void> logError(String error) async {
    print("Logging error: $error");

    try {
      final timeStamp = DateTime.now();
      final logMessage = 'Crash: $error at $timeStamp';
      await _errorLogger.logError(logMessage);
    } catch (e) {
      print('Error logging error: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> loadErrorLogs() async {
    try {
      print("Loading error logs...");
      final errorLogs = await _errorLogger.loadErrorLogs();
      return errorLogs.map((log) => log.toJson()).toList();
    } catch (e) {
      print('Error loading error logs: $e');
      return [];
    }
  }

  static Future<List<LogEntry>> loadErrorLogsAsCrashData() async {
    try {
      print("Loading error logs as crash data...");
      final errorLogs = await _errorLogger.loadErrorLogs();
      return errorLogs.map((log) => LogEntry.fromJson(log.toJson())).toList();
    } catch (e) {
      print('Error loading error logs as crash data: $e');
      return [];
    }
  }
}

class ErrorLogger {
  Directory _directory = Directory("");
  File _logFile = File('');

  ErrorLogger() {
    _initialize();
    print("here3");
  }

  Future<void> _initialize() async {
    print("here4");
    _directory = await getApplicationDocumentsDirectory();
    _logFile = File('${_directory.path}/crash_log21.txt');
    if (!await _logFile.exists()) {
      await _logFile.create(recursive: true);
    }
  }

  Future<void> logError(String error) async {
    print("here6");
    try {
      final timeStamp = DateTime.now();
      final logEntry =
          LogEntry('Crash: $error', timeStamp, getSeverityFromError(error));
      final logJson = json.encode(logEntry.toJson());
      await _logFile.writeAsString('$logJson\n', mode: FileMode.append);
    } catch (e) {
      print('Error logging error: $e');
    }
  }

  Future<List<LogEntry>> loadErrorLogs() async {
    print("here7");
    try {
      if (await _logFile.exists()) {
        final logs = await _logFile.readAsLines();
        return logs.map((log) {
          try {
            return LogEntry.fromJson(json.decode(log.trim()));
          } catch (e) {
            print('Error parsing log entry: $log\nError: $e');
            return LogEntry('', DateTime.now(), Severity.high);
          }
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error loading error logs: $e');
      return [];
    }
  }

  Future<String> retrieveLogsInJSON() async {
    print("here8");
    try {
      if (await _logFile.exists()) {
        final logs = await loadErrorLogs();
        return json.encode({'logs': logs.map((log) => log.toJson()).toList()});
      } else {
        return json.encode({'logs': []});
      }
    } catch (e) {
      print('Error retrieving logs: $e');
      return json.encode({'error': 'Error retrieving logs'});
    }
  }
}
