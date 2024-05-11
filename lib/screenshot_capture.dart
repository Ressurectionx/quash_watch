import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';

class ScreenshotController {
  final GlobalKey containerKey = GlobalKey();

  Future<String?> captureAndSave(String fileName) async {
    Uint8List? content = await _captureAsUiImage();
    if (content == null) return null;
    final directory = Directory('/storage/emulated/0/Download');
    final path = '${directory.path}/$fileName.png';
    // Save the screenshot to the specified path
    await File(path).writeAsBytes(content);
    return path;
  }

  Future<Uint8List?> _captureAsUiImage() async {
    try {
      final RenderRepaintBoundary? boundary = containerKey.currentContext
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
}
