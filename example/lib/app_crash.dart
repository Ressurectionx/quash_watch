// ignore_for_file: depend_on_referenced_packages

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quash_watch/controllers/quash_crash_controller.dart';
import 'package:intl/intl.dart';
import 'package:quash_watch/utils/quash_utils.dart';
import 'package:quash_watch/quash_watch.dart';

class AppCrashScreen extends StatefulWidget {
  const AppCrashScreen({Key? key}) : super(key: key);

  @override
  State<AppCrashScreen> createState() => _AppCrashScreenState();
}

class _AppCrashScreenState extends State<AppCrashScreen> {
  @override
  void initState() {
    super.initState();
  }

  void throwRandomException() {
    // Define a list of potential exceptions
    final exceptions = [
      Exception('This is a random exception!'),
      ArgumentError('Wrong argument provided!'),
      UnsupportedError('This feature is not supported!'),
    ];

    // Generate a random index within the list bounds
    final randomIndex = Random().nextInt(exceptions.length);
    setState(() {});
    // Throw the exception at the random index
    throw exceptions[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    QuashWatch quashWatch = QuashWatch();
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
                throwRandomException();
              },
              child: const Text('Crash The App'),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<LogEntry>>(
              future: quashWatch.loadErrorLogsAsCrashData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<LogEntry> logs = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      final LogEntry crashData = logs[index];
                      return ListTile(
                        leading: Icon(
                          Icons.bug_report,
                          color: getColorFromSeverity(crashData.severity),
                        ), // Add bug report icon at leading
                        trailing: Text(
                          crashData.severity.toString().split('.').last,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getColorFromSeverity(crashData.severity)),
                        ), // Show severity with bold and color
                        title: Text(
                          crashData.message.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ), // Bold title
                        subtitle: Text(
                          DateFormat('dd/MM/yy hh:mm')
                              .format(crashData.timeStamp),
                        ), // Show time and date in format dd/MM/yy hh:mm
                        // ... other UI elements using crashData properties
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
