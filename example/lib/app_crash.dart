import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quash_watch/crash_log.dart';

enum Severity { low, medium, high }

class AppCrashScreen extends StatefulWidget {
  const AppCrashScreen({Key? key}) : super(key: key);

  @override
  State<AppCrashScreen> createState() => _AppCrashScreenState();
}

class _AppCrashScreenState extends State<AppCrashScreen> {
  final List<CrashData> _crashLogs = [];

  @override
  void initState() {
    super.initState();
    CrashLogController.handleFlutterErrors();
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
              onPressed: () {
                CrashLogController.logError('Manually triggered crash');
                // Trigger a crash here if needed
              },
              child: const Text('Crash The App'),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<String>>(
              future: CrashLogController.loadErrorLogs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final logs = snapshot.data ?? [];
                  // Process logs and display UI
                  return ListView.builder(
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      // Display logs in UI
                      return ListTile(
                        title: Text(logs[index]),
                      );
                    },
                  );
                }
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
