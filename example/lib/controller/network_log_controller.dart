// controllers/network_log_controller.dart

import 'package:dio/dio.dart';
import 'package:quash_watch/quash_watch.dart';

class NetworkLogController {
  final Dio _dio = Dio();
  final QuashWatch _quashWatch = QuashWatch();
  List<Map<String, dynamic>> logs = [];

  Future<void> hitAPI() async {
    try {
      _dio.interceptors.add(QuashNetworkWatch());

      await _dio.get(
        'https://weatherapi-com.p.rapidapi.com/sports.json?q=London',
        options: Options(
          headers: {
            'X-Rapidapi-Key':
                'ab68db8d09msh2a9ee72e54f4468p177d30jsn32113fd3e6d2',
            'X-Rapidapi-Host': 'weatherapi-com.p.rapidapi.com',
          },
        ),
      );
      // Save the network logs using NetworkLogger method

      // _quashWatch.saveNetworkLogs({
      //   'timestamp': DateTime.now().toIso8601String(),
      //   'url': response.requestOptions.uri.toString(),
      //   'statusCode': response.statusCode,
      //   'responseData': json.decode(response.toString()),
      // });
    } catch (e) {
      print('Error: $e');
    }
    logs = await getNetworkLogs();
  }

  Future<List<Map<String, dynamic>>> getNetworkLogs() async {
    return await _quashWatch.retrieveNetworkLogs();
  }
}
