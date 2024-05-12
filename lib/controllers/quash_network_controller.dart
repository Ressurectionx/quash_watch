import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:quash_watch/models/network_log_entry_model.dart';

import 'package:dio/dio.dart';

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
  final String _logFilePath = 'network_logs.txt';

  Future<void> saveLogsToFile(Map<String, dynamic> log) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_logFilePath');
    final logString = jsonEncode(log);
    await file.writeAsString('$logString\n', mode: FileMode.append);
  }

  Future<List<Map<String, dynamic>>> retrieveLogsAsJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_logFilePath');
    final lines = await file.readAsLines();
    List<Map<String, dynamic>> logs = [];
    lines.forEach((line) {
      logs.add(jsonDecode(line));
    });
    return logs;
  }

  Future<List<NetworkLogEntry>> retrieveLogsAsModelList() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_logFilePath');
    final lines = await file.readAsLines();
    List<NetworkLogEntry> logs = [];
    lines.forEach((line) {
      logs.add(NetworkLogEntry.fromJson(jsonDecode(line)));
    });
    return logs;
  }
}
