import 'package:flutter/material.dart';
import 'package:quash_watch/utils/quash_utils.dart';

Color getStatusCodeColor(int statusCode) {
  if (statusCode >= 200 && statusCode < 300) {
    return Colors.green;
  } else if (statusCode >= 300 && statusCode < 400) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}

Color getColorFromSeverity(Severity severity) {
  switch (severity) {
    case Severity.low:
      return Colors.green;
    case Severity.medium:
      return Colors.orange;
    case Severity.high:
      return Colors.red;
  }
}
