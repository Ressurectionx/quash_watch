import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quash_watch/crash_data_model.dart';
import 'package:quash_watch/quash_crash_watch.dart';
import 'package:quash_watch/quash_network_watch.dart';
import 'package:quash_watch/quash_screen_watch.dart';

import 'quash_watch_platform_interface.dart';

class QuashWatch {
  final NetworkLogger _networkLogger = NetworkLogger();
  final ErrorLogger _errorLogger = ErrorLogger();
  // final QuashScreenWatch _screenshotController = QuashScreenWatch(child: widget,);

  Future<String?> getPlatformVersion() {
    return QuashWatchPlatform.instance.getPlatformVersion();
  }

  Future<void> saveNetworkLogs(Map<String, dynamic> logs) async {
    await _networkLogger.saveLogsToFile(logs);
  }

  Future<String> retrieveNetworkLogs() async {
    final logs = await _networkLogger.retrieveLogsAsJson();
    return logs.toString(); // adjust the formatting as needed
  }

  Future<List<Map<String, dynamic>>> loadErrorLogs() async {
    List<LogEntry> errorLogs = await _errorLogger.loadErrorLogs();
    List<Map<String, dynamic>> jsonLogs = [];
    for (LogEntry log in errorLogs) {
      jsonLogs.add(log.toJson());
    }
    return jsonLogs;
  }

  // If you also want to parse JSON into CrashData objects
  Future<List<LogEntry>> loadErrorLogsAsCrashData() async {
    List<LogEntry> errorLogs = await _errorLogger.loadErrorLogs();
    List<LogEntry> crashDataList = [];
    for (LogEntry log in errorLogs) {
      crashDataList.add(LogEntry.fromJson(log.toJson()));
    }
    // Return an empty list if there are no error logs
    return crashDataList;
  }

  Future<void> logError(String error) async {
    await _errorLogger.logError(error);
  }

  // Future<String?> captureAndSaveScreenshot(String fileName) async {
  //   return _screenshotController.captureAndSave(fileName);
  // }
}
