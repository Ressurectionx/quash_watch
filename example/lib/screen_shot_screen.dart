import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quash_watch/controllers/quash_screen_controller.dart';

class ScreenshotScreen extends StatelessWidget {
  const ScreenshotScreen({Key? key}) : super(key: key);

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

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({Key? key}) : super(key: key);

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer _countdownTimer;
  int _countdown = 60;

  @override
  void initState() {
    super.initState();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _countdown = 60;
          //  _countdownTimer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            textAlign: TextAlign.center,
            _countdown.toString(),
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
