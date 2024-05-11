import 'package:flutter/material.dart';
import 'package:quash_watch/crash_log.dart';
import 'package:quash_watch_example/quash_board.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    CrashLogController
        .handleFlutterErrors(); // You can also do other things here like show a custom error UI
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
