import 'dart:io';
import 'package:flutter/material.dart';

class ErrorLogWidget extends StatefulWidget {
  const ErrorLogWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ErrorLogWidgetState createState() => _ErrorLogWidgetState();
}

class _ErrorLogWidgetState extends State<ErrorLogWidget> {
  List<String> errorLogs = [];

  @override
  void initState() {
    super.initState();
    loadErrorLogs();
  }

  Future<void> loadErrorLogs() async {
    final directory = Directory('/storage/emulated/0/Download');
    final logFile = File('${directory.path}/error_log.txt');
    if (await logFile.exists()) {
      final logs = await logFile.readAsLines();
      setState(() {
        errorLogs = logs.reversed.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: errorLogs.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => ListTile(
        title: Text(errorLogs[index]),
      ),
    );
  }
}
