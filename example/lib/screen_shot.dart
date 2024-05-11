import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quash_watch/screenshot_capture.dart';

class ScreenshotScreen extends StatefulWidget {
  const ScreenshotScreen({super.key});

  @override
  State<ScreenshotScreen> createState() => _ScreenshotScreenState();
}

class _ScreenshotScreenState extends State<ScreenshotScreen> {
  @override
  Widget build(BuildContext context) {
    final ScreenshotController _screenshotController = ScreenshotController();

    late Timer _timer;

    int _countdown = 2;

    @override
    void initState() {
      super.initState();
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        setState(() {
          if (_countdown > 0) {
            _countdown--;
          } else {
            _countdown = 5;
            _screenshotController.captureAndSave("saving");
          }
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Screenshot Screen'),
      ),
      body: Center(
        child: Text(_countdown.toString()),
      ),
    );
  }
}
