import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:quash_watch_example/quash_board.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    // Log the error
    logError(
      details.exceptionAsString(),
    );
    // You can also do other things here like show a custom error UI
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigation(),
    );
  }
}
// void main() {
//   FlutterError.onError = (FlutterErrorDetails details) {
//     // Log the error
//     logError(details.exceptionAsString());
//     // You can also do other things here like show a custom error UI
//   };
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final ScreenshotController _screenshotController = ScreenshotController();

//   late Timer _timer;

//   final int _countdown = 2;

//   @override
//   void initState() {
//     super.initState();
//     // _timer = Timer.periodic(const Duration(seconds: 5), (_) {
//     //   setState(() {
//     //     if (_countdown > 0) {
//     //       _countdown--;
//     //     } else {
//     //       _countdown = 5;
//     //       captureAndSave();
//     //     }
//     //   });
//     // });
//   }

//   void crashApp() {
//     // Randomly select an exception type to throw
//     final random =
//         Random().nextInt(3); // Generate random number between 0 and 2
//     switch (random) {
//       case 0:
//         throw const FormatException('This is a FormatException');
//       case 1:
//         throw const FileSystemException(
//             'This is a FileSystemException', '/path');
//       case 2:
//         throw UnsupportedError('Division by zero is not supported');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: RepaintBoundary(
//         key: _screenshotController.containerKey,
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             title: const Text('Quash Watch'),
//           ),
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Text(
//                   'Capturing in $_countdown seconds',
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               ElevatedButton(
//                 onPressed: () => crashApp(),
//                 child: const Text('Crash The App'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void captureAndSave() async {
//     String? savedPath = await _screenshotController.captureAndSave("Save");
//     if (savedPath != null) {
//       print('Screenshot saved at: $savedPath');
//     } else {
//       print('Failed to save screenshot.');
//     }
//   }
// }

void logError(String error) async {
  final directory = Directory('/storage/emulated/0/Download');
  final logFile = File('${directory.path}/error_log.txt');
  final timeStamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  final logMessage = 'Crash: $error at $timeStamp';
  await logFile.writeAsString('$logMessage\n', mode: FileMode.append);
}
