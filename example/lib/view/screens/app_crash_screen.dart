// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quash_watch/quash_watch.dart';
import 'package:intl/intl.dart';

import '../../controller/app_crash_controller.dart';
import '../../utils/helpers.dart';

// class AppCrashScreen extends StatefulWidget {
//   const AppCrashScreen({Key? key}) : super(key: key);

//   @override
//   State<AppCrashScreen> createState() => _AppCrashScreenState();
// }

// class _AppCrashScreenState extends State<AppCrashScreen> {
//   final AppCrashController _appCrashController = AppCrashController();
//   QuashWatch quashWatch = QuashWatch();
//   @override
//   void initState() {
//     super.initState();
//     errorCapture();
//   }

//   Future<void> errorCapture() async {
//     FlutterError.onError = (FlutterErrorDetails details) async {
//       await quashWatch.logError(details.exceptionAsString());
//     };
//   }

//   void throwRandomException() {
//     // Define a list of potential exceptions
//     final exceptions = [
//       Exception('This is a random exception!'),
//       ArgumentError('Wrong argument provided!'),
//       UnsupportedError('This feature is not supported!'),
//     ];

//     // Generate a random index within the list bounds
//     final randomIndex = Random().nextInt(exceptions.length);

//     // Throw the exception at the random index
//     throw exceptions[randomIndex];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('App Crash Screen'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           InkWell(
//             onTap: () async {
//               //throw "asdasd";
//               throwRandomException();
//             },
//             child: Container(
//               height: 50,
//               width: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.red),
//               ),
//               child: const Center(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'Crash The App',
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Expanded(
//             child: FutureBuilder<List<LogEntry>>(
//               future: _appCrashController.loadErrorLogsAsCrashData(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else {
//                   final List<LogEntry> logs = snapshot.data ?? [];
//                   return ListView.builder(
//                     itemCount: logs.length,
//                     itemBuilder: (context, index) {
//                       final LogEntry crashData = logs[index];
//                       return ListTile(
//                         leading: Icon(
//                           Icons.bug_report,
//                           color: getColorFromSeverity(crashData.severity),
//                         ), // Add bug report icon at leading
//                         trailing: Text(
//                           crashData.severity.toString().split('.').last,
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: getColorFromSeverity(crashData.severity)),
//                         ), // Show severity with bold and color
//                         title: Text(
//                           crashData.message.toString(),
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ), // Bold title
//                         subtitle: Text(
//                           DateFormat('dd/MM/yy hh:mm')
//                               .format(crashData.timeStamp),
//                         ), // Show time and date in format dd/MM/yy hh:mm
//                         // ... other UI elements using crashData properties
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// ignore_for_file: depend_on_referenced_packages

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quash_watch/controllers/quash_crash_controller.dart';
import 'package:intl/intl.dart';
import 'package:quash_watch/utils/quash_utils.dart';

class AppCrashScreen extends StatefulWidget {
  const AppCrashScreen({Key? key}) : super(key: key);

  @override
  State<AppCrashScreen> createState() => _AppCrashScreenState();
}

class _AppCrashScreenState extends State<AppCrashScreen> {
  QuashWatch watch = QuashWatch();
  AppCrashController controller = AppCrashController();
  @override
  void initState() {
    super.initState();
    watch.handleErrors();
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
                setState(() {});
                controller.throwRandomException();
              },
              child: const Text('Crash The App'),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<LogEntry>>(
              future: controller.loadErrorLogsAsCrashData(),
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
                        ),
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
