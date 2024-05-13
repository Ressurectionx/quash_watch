import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:quash_watch/models/network_log_entry_model.dart';

class QuashNetworkWatch extends Interceptor {
  final NetworkLogger _networkLogger = NetworkLogger();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _networkLogger.saveLogsToFile({
      'timestamp': DateTime.now().toIso8601String(),
      'url': response.requestOptions.uri.toString(),
      'statusCode': response.statusCode,
      'responseData': response.data,
    });
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _networkLogger.saveLogsToFile({
      'timestamp': DateTime.now().toIso8601String(),
      'url': err.requestOptions.uri.toString(),
      'statusCode': err.response?.statusCode,
      'responseData': err.response?.data,
    });
    super.onError(err, handler);
  }

  // Getter method to access saveLogsToFile method from NetworkLogger
  Future<void> saveLogsToFile(Map<String, dynamic> logs) async {
    await _networkLogger.saveLogsToFile(logs);
  }

  // Getter method to access retrieveLogsAsJson method from NetworkLogger
  Future<List<Map<String, dynamic>>> retrieveLogsAsJson() async {
    return await _networkLogger.retrieveLogsAsJson();
  }
}

class NetworkLogger {
  Directory _directory = Directory("");
  File _logFile = File('');

  NetworkLogger() {
    _initialize();
  }

  Future<void> _initialize() async {
    _directory =
        await getApplicationDocumentsDirectory(); //Directory('/storage/emulated/0/Download');
    _logFile = File('${_directory.path}/network_log1.txt');
    // Create the log file if it doesn't exist
    if (!await _logFile.exists()) {
      await _logFile.create(recursive: true);
    }
  }

  Future<void> saveLogsToFile(Map<String, dynamic> log) async {
    try {
      // Convert log map to JSON string
      final logString = jsonEncode(log);

      // Append log string to file
      await _logFile.writeAsString('$logString\n', mode: FileMode.append);
    } catch (error) {
      print('Error saving logs to file: $error');
      // Optionally, consider logging the error to a different location (e.g., console)
    }
  }

  Future<List<Map<String, dynamic>>> retrieveLogsAsJson() async {
    final lines = await _logFile.readAsLines();
    List<Map<String, dynamic>> logs = [];
    lines.forEach((line) {
      logs.add(jsonDecode(line));
    });
    return logs;
  }

  Future<List<NetworkLogEntry>> retrieveLogsAsModelList() async {
    final lines = await _logFile.readAsLines();
    List<NetworkLogEntry> logs = [];
    lines.forEach((line) {
      logs.add(NetworkLogEntry.fromJson(jsonDecode(line)));
    });
    return logs;
  }
}
