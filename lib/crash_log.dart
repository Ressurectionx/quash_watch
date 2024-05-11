import 'dart:io';
import 'package:flutter/material.dart';

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

  static Future<List<String>> loadErrorLogs() async {
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
      await _logFile.writeAsString('$error\n', mode: FileMode.append);
    } catch (e) {
      // Handle file operation errors
      print('Error logging error: $e');
    }
  }

  Future<List<String>> loadErrorLogs() async {
    try {
      if (await _logFile.exists()) {
        final logs = await _logFile.readAsLines();
        return logs.reversed.toList();
      } else {
        return [];
      }
    } catch (e) {
      // Handle file operation errors
      print('Error loading error logs: $e');
      return [];
    }
  }
}
