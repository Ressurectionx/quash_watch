import 'dart:io';

import 'package:path_provider/path_provider.dart';

class NetworkLogger {
  Future<void> saveLogsToFile(String logs) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/network_logs.txt');
    await file.writeAsString(logs, mode: FileMode.append);
  }

  Future<String> retrieveLogsFromFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/network_logs.txt');
    return file.readAsString();
  }
}
