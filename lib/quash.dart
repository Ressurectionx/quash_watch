import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quash_watch/controllers/quash_crash_controller.dart';
import 'package:quash_watch/controllers/quash_network_controller.dart';
import 'package:quash_watch/models/log_entry_model.dart';

import 'package:quash_watch/controllers/quash_screen_controller.dart';
import 'package:quash_watch/quash_watch_platform_interface.dart';

class QuashWatch {
  final QuashNetworkWatch _networkWatch = QuashNetworkWatch();

  Future<String?> getPlatformVersion() {
    return QuashWatchPlatform.instance.getPlatformVersion();
  }

  Future<void> handleErrors() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      // Log the error
      QuashCrashWatch.logError(details.exceptionAsString());
      // You can also do other things here like show a custom error UI
    };
  }

  Future<void> saveNetworkLogs(Map<String, dynamic> logs) async {
    // Use getter method to save network logs
    await _networkWatch.saveLogsToFile(logs);
  }

  Future<void> watchScreen(Widget screen) async {
    QuashScreenWatch(
      child: screen,
    );
  }

  Future<List<Map<String, dynamic>>> retrieveNetworkLogs() async {
    // Use getter method to retrieve network logs
    final logs = await _networkWatch.retrieveLogsAsJson();
    return logs; // adjust the formatting as needed
  }

  Future<void> logError(String error) async {
    await QuashCrashWatch.logError(error);
  }

  Future<List<Map<String, dynamic>>> loadErrorLogs() async {
    return QuashCrashWatch.loadErrorLogs();
  }

  Future<List<LogEntry>> loadErrorLogsAsCrashData() async {
    return QuashCrashWatch.loadErrorLogsAsCrashData();
  }
}

// class QuashWatch {
//   final NetworkLogger _networkLogger = NetworkLogger();
//   final ErrorLogger _errorLogger = ErrorLogger();
//   // final QuashScreenWatch _screenshotController = QuashScreenWatch(child: widget,);

//   Future<String?> getPlatformVersion() {
//     return QuashWatchPlatform.instance.getPlatformVersion();
//   }

//   Future<void> saveNetworkLogs(Map<String, dynamic> logs) async {
//     await _networkLogger.saveLogsToFile(logs);
//   }

//   Future<String> retrieveNetworkLogs() async {
//     final logs = await _networkLogger.retrieveLogsAsJson();
//     return logs.toString(); // adjust the formatting as needed
//   }

//   Future<List<Map<String, dynamic>>> loadErrorLogs() async {
//     List<LogEntry> errorLogs = await _errorLogger.loadErrorLogs();
//     List<Map<String, dynamic>> jsonLogs = [];
//     for (LogEntry log in errorLogs) {
//       jsonLogs.add(log.toJson());
//     }
//     return jsonLogs;
//   }

//   // If you also want to parse JSON into CrashData objects
//   Future<List<LogEntry>> loadErrorLogsAsCrashData() async {
//     List<LogEntry> errorLogs = await _errorLogger.loadErrorLogs();
//     List<LogEntry> crashDataList = [];
//     for (LogEntry log in errorLogs) {
//       crashDataList.add(LogEntry.fromJson(log.toJson()));
//     }
//     // Return an empty list if there are no error logs
//     return crashDataList;
//   }

//   Future<void> logError(String error) async {
//     await _errorLogger.logError(error);
//   }

//   // Future<String?> captureAndSaveScreenshot(String fileName) async {
//   //   return _screenshotController.captureAndSave(fileName);
//   // }
// }
