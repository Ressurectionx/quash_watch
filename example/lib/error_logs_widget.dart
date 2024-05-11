import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quash_watch/crash_log.dart';

class ErrorLogWidget extends StatefulWidget {
  const ErrorLogWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ErrorLogWidgetState createState() => _ErrorLogWidgetState();
}

class _ErrorLogWidgetState extends State<ErrorLogWidget> {
  List<String> errorLogs = [];
  ErrorLogger logger = ErrorLogger();

  @override
  void initState() {
    super.initState();
    loadErrorLogs();
  }

  Future<void> loadErrorLogs() async {
    final logs = await logger.loadErrorLogs();
    setState(() {
      errorLogs = logs;
    });
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
