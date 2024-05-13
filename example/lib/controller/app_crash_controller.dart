import 'package:quash_watch/quash_watch.dart';

class AppCrashController {
  final QuashWatch quashWatch = QuashWatch();

  Future<List<LogEntry>> loadErrorLogsAsCrashData() async {
    return await quashWatch.loadErrorLogsAsCrashData();
  }
}
