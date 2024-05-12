import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quash_watch/quash_screen_watch.dart';

class ScreenshotScreen extends StatelessWidget {
  const ScreenshotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screenshot Screen'),
      ),
      body: const Center(
        child: QuashScreenWatch(
          child: CountdownWidget(),
        ),
      ),
    );
  }
}

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({Key? key}) : super(key: key);

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer _countdownTimer;
  int _countdown = 2;

  @override
  void initState() {
    super.initState();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
      });
      if (_countdown == 0) {
        _countdownTimer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _countdown == 0 ? "Taking Screenshot" : _countdown.toString(),
      style: const TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: Colors.amber,
      ),
    );
  }
}
