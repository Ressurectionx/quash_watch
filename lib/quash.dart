import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quash_watch/controllers/quash_crash_controller.dart';
import 'package:quash_watch/controllers/quash_network_controller.dart';
import 'package:quash_watch/models/log_entry_model.dart';

import 'package:quash_watch/controllers/quash_screen_controller.dart';

class QuashWatch {
  final QuashNetworkWatch _networkWatch = QuashNetworkWatch();

  Future<void> handleErrors() async {
    // Set up the error handler
    FlutterError.onError = (FlutterErrorDetails details) async {
      // Log the error using QuashCrashWatch
      await QuashCrashWatch.logError(details.exception.toString());
      // You can also add other error handling logic here
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
