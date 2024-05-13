import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quash_watch/quash_watch.dart';

import '../widgets/countdown_widget.dart';

class ScreenshotScreen extends StatelessWidget {
  const ScreenshotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuashScreenWatch(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Screenshot Screen'),
        ),
        body: const Center(
          child: CountdownWidget(),
        ),
      ),
    );
  }
}
