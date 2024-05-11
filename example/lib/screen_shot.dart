import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quash_watch/screenshot_capture.dart';

class ScreenshotScreen extends StatefulWidget {
  const ScreenshotScreen({Key? key}) : super(key: key);

  @override
  State<ScreenshotScreen> createState() => _ScreenshotScreenState();
}

class _ScreenshotScreenState extends State<ScreenshotScreen> {
  late ScreenshotController
      screenshotController; // Declare ScreenshotController

  late Timer timer;
  int countdown = 2;

  @override
  void initState() {
    super.initState();
    screenshotController =
        ScreenshotController(); // Initialize ScreenshotController

    // Initialize the timer
    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          countdown = 5;
          screenshotController.captureAndSave("saving");
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Dispose the timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: screenshotController.containerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Screenshot Screen'),
        ),
        body: Center(
          child: Text(
              countdown == 0 ? "Taking Screenshot" : countdown.toString(),
              style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber)),
        ),
      ),
    );
  }
}
