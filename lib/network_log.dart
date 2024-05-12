import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class QuashNetworkWatch extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    NetworkLogger().saveLogsToFile({
      'timestamp': DateTime.now().toIso8601String(),
      'url': response.requestOptions.uri.toString(),
      'statusCode': response.statusCode,
      'responseData': response.data,
    });
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    NetworkLogger().saveLogsToFile({
      'timestamp': DateTime.now().toIso8601String(),
      'url': err.requestOptions.uri.toString(),
      'statusCode': err.response?.statusCode,
      'responseData': err.response?.data,
    });
    super.onError(err, handler);
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

class NetworkLogEntry {
  final String timestamp;
  final String url;
  final int statusCode;
  final Map<String, dynamic> responseData;

  NetworkLogEntry({
    required this.timestamp,
    required this.url,
    required this.statusCode,
    required this.responseData,
  });

  factory NetworkLogEntry.fromJson(Map<String, dynamic> json) {
    return NetworkLogEntry(
      timestamp: json['timestamp'],
      url: json['url'],
      statusCode: json['statusCode'],
      responseData: json['responseData'],
    );
  }
}
