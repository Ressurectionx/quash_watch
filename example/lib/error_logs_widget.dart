import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quash_watch/controllers/quash_crash_controller.dart';
import 'package:quash_watch/models/log_entry_model.dart';

class ErrorLogWidget extends StatefulWidget {
  const ErrorLogWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ErrorLogWidgetState createState() => _ErrorLogWidgetState();
}

class _ErrorLogWidgetState extends State<ErrorLogWidget> {
  ErrorLogger logger = ErrorLogger();

  @override
  void initState() {
    super.initState();
    loadErrorLogs();
  }

  List<LogEntry> errorLogs = [];

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
        title: Text(errorLogs[index].toString()),
      ),
    );
  }
}
