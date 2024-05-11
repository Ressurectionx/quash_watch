import 'package:flutter/services.dart';
import 'package:quash_watch/crash_log.dart';
import 'package:quash_watch/network_log.dart';
import 'package:quash_watch/screenshot_capture.dart';

import 'quash_watch_platform_interface.dart';

class QuashWatch {
  final NetworkLogger _networkLogger = NetworkLogger();
  final ErrorLogger _errorLogger = ErrorLogger();
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<String?> getPlatformVersion() {
    return QuashWatchPlatform.instance.getPlatformVersion();
  }

  Future<void> saveNetworkLogs(String logs) async {
    await _networkLogger.saveLogsToFile(logs);
  }

  Future<String> retrieveNetworkLogs() async {
    return _networkLogger.retrieveLogsFromFile();
  }

  Future<List<String>> loadErrorLogs() async {
    return _errorLogger.loadErrorLogs();
  }

  Future<void> logError(String error) async {
    await _errorLogger.logError(error);
  }

  Future<String?> captureAndSaveScreenshot(String fileName) async {
    return _screenshotController.captureAndSave(fileName);
  }
}
