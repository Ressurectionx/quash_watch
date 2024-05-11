import 'package:flutter/material.dart';

class NetworkLog extends StatelessWidget {
  const NetworkLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Network Log'),
        ),
        body: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text('Crash The App')]));
  }
}
