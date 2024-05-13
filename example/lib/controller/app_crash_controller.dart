import 'dart:math';

import 'package:quash_watch/quash_watch.dart';

class AppCrashController {
  final QuashWatch quashWatch = QuashWatch();
  void throwRandomException() {
    // Define a list of potential exceptions
    final exceptions = [
      Exception('This is a random exception!'),
      ArgumentError('Wrong argument provided!'),
      UnsupportedError('This feature is not supported!'),
    ];

    // Generate a random index within the list bounds
    final randomIndex = Random().nextInt(exceptions.length);

    // Throw the exception at the random index
    throw exceptions[randomIndex];
  }

  Future<List<LogEntry>> loadErrorLogsAsCrashData() async {
    return await quashWatch.loadErrorLogsAsCrashData();
  }
}
