import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class QuashScreenWatch extends StatefulWidget {
  final Widget child;
  const QuashScreenWatch({Key? key, required this.child}) : super(key: key);

  @override
  _QuashScreenWatchState createState() => _QuashScreenWatchState();
}

class _QuashScreenWatchState extends State<QuashScreenWatch> {
  final GlobalKey _containerKey = GlobalKey();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      _captureAndSave("screenshot");
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _captureAndSave(String fileName) async {
    Uint8List? content = await _captureAsUiImage();
    if (content == null) return;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd_MM_yyyy_hh_mm');
    final String formattedDateTime = formatter.format(now);
    final directory = Directory('/storage/emulated/0/Download');
    //await getDownloadsDirectory();
    final path = '${directory.path}/${formattedDateTime}screenshot.png';
    // Save the screenshot to the specified path
    await File(path).writeAsBytes(content);
    print('Screenshot saved to: $path');
  }

  Future<Uint8List?> _captureAsUiImage() async {
    try {
      final RenderRepaintBoundary? boundary = _containerKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        print(
            "Error: Unable to capture screenshot. RenderRepaintBoundary not found.");
        return null;
      }
      final image =
          await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print("Error capturing screenshot: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _containerKey,
      child: widget.child,
    );
  }
}
