import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quash_watch/crash_data_model.dart';

class CrashLogController {
  static final ErrorLogger _errorLogger = ErrorLogger();

  static Future<void> handleFlutterErrors() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      // Log the error
      logError(details.exceptionAsString());
      // You can also do other things here like show a custom error UI
    };
  }

  static Future<void> logError(String error) async {
    final timeStamp = DateTime.now();
    final logMessage = 'Crash: $error at $timeStamp';
    await _errorLogger.logError(logMessage);
  }

  static Future<List<LogEntry>> loadErrorLogs() async {
    return _errorLogger.loadErrorLogs();
  }
}

class ErrorLogger {
  late final Directory _directory;
  late final File _logFile;

  ErrorLogger() {
    _directory = Directory('/storage/emulated/0/Download');
    _logFile = File('${_directory.path}/error_log.txt');
  }

  Future<void> logError(String error) async {
    try {
      final timeStamp = DateTime.now();
      final logEntry =
          LogEntry('Crash: $error', timeStamp, getSeverityFromError(error));
      final logJson = json.encode(logEntry.toJson());
      await _logFile.writeAsString('$logJson\n', mode: FileMode.append);
    } catch (e) {
      // Handle file operation errors
      print('Error logging error: $e');
    }
  }

  Future<List<LogEntry>> loadErrorLogs() async {
    try {
      if (await _logFile.exists()) {
        final logs = await _logFile.readAsLines();
        return logs.map((log) {
          try {
            return LogEntry.fromJson(json.decode(log.trim()));
          } catch (e) {
            // Log and handle any parsing errors
            print('Error parsing log entry: $log\nError: $e');
            // Return a default LogEntry or handle the error as needed
            return LogEntry('', DateTime.now(), Severity.high);
          }
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      // Handle file operation errors
      print('Error loading error logs: $e');
      return [];
    }
  }

  Future<String> retrieveLogsInJSON() async {
    try {
      if (await _logFile.exists()) {
        final logs = await loadErrorLogs();
        // Convert logs to JSON format
        return json.encode({'logs': logs.map((log) => log.toJson()).toList()});
      } else {
        return json.encode({'logs': []});
      }
    } catch (e) {
      // Handle file operation errors
      print('Error retrieving logs: $e');
      return json.encode({'error': 'Error retrieving logs'});
    }
  }
}

enum Severity { low, medium, high }

Severity getSeverityFromError(String error) {
  if (error.contains('FormatException')) {
    return Severity.low;
  } else if (error.contains('FileSystemException')) {
    return Severity.medium;
  } else {
    return Severity.high;
  }
}
