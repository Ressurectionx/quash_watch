import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quash_watch_example/error_logs_widget.dart';
import 'package:intl/intl.dart';

enum Severity { low, medium, high }

class AppCrashScreen extends StatefulWidget {
  const AppCrashScreen({Key? key}) : super(key: key);

  @override
  State<AppCrashScreen> createState() => _AppCrashScreenState();
}

class _AppCrashScreenState extends State<AppCrashScreen> {
  final List<CrashData> _crashLogs = [];

  void crashApp() {
    final random = Random().nextInt(3);
    final timestamp = DateTime.now();
    late String errorType;
    late Severity severity;

    switch (random) {
      case 0:
        errorType = 'FormatException';
        severity = Severity.low;
        break;
      case 1:
        errorType = 'FileSystemException';
        severity = Severity.medium;
        break;
      case 2:
        errorType = 'UnsupportedError';
        severity = Severity.high;
        break;
    }

    _crashLogs.insert(0, CrashData(timestamp, errorType, severity));
    setState(() {});

    switch (random) {
      case 0:
        throw const FormatException('This is a FormatException');
      case 1:
        throw const FileSystemException(
            'This is a FileSystemException', '/path');
      case 2:
        throw UnsupportedError('Division by zero is not supported');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Crash Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: crashApp,
              child: const Text('Crash The App'),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _crashLogs.isEmpty
                ? const Center(child: Text('No Crashes Logged'))
                : ListView.builder(
                    itemCount: _crashLogs.length,
                    itemBuilder: (context, index) {
                      final crashData = _crashLogs[index];
                      final iconColor =
                          getColorFromSeverity(crashData.severity);
                      final formattedDate =
                          DateFormat('dd/MM/yyyy').format(crashData.timestamp);
                      final formattedTime =
                          DateFormat('HH:mm').format(crashData.timestamp);
                      return ListTile(
                        dense: true,
                        leading: Icon(
                          Icons.bug_report,
                          color: iconColor,
                        ),
                        title: Text(
                          crashData.errorType,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '$formattedDate $formattedTime',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          '${crashData.severity}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: getColorFromSeverity(crashData.severity)),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class CrashData {
  final DateTime timestamp;
  final String errorType;
  final Severity severity;

  CrashData(this.timestamp, this.errorType, this.severity);
}

Color getColorFromSeverity(Severity severity) {
  switch (severity) {
    case Severity.low:
      return Colors.green;
    case Severity.medium:
      return Colors.orange;
    case Severity.high:
      return Colors.red;
  }
}
