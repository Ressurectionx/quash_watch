import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quash_watch/controllers/quash_network_controller.dart';

class NetworkLogScreen extends StatefulWidget {
  const NetworkLogScreen({Key? key}) : super(key: key);

  @override
  _NetworkLogScreenState createState() => _NetworkLogScreenState();
}

class _NetworkLogScreenState extends State<NetworkLogScreen> {
  List<Map<String, dynamic>> logs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Log'),
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () async {
              // Hit the API using Dio
              try {
                Dio dio = Dio();
                dio.interceptors.add(QuashNetworkWatch());

                Response response = await dio.get(
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
                // await NetworkLogger('network_logs.txt').saveLogsToFile({
                //   'timestamp': DateTime.now().toIso8601String(),
                //   'url': response.requestOptions.uri.toString(),
                //   'statusCode': response.statusCode,
                //   'responseData': json.decode(response.toString()),
                // });

                // // Save the response data and show popup
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return AlertDialog(
                //       title: const Text('API Response'),
                //       content: Text(
                //           'Status Code: ${response.statusCode}\nResponse Data: ${response.data}'),
                //       actions: [
                //         TextButton(
                //           onPressed: () {
                //             Navigator.of(context).pop();
                //           },
                //           child: const Text('Close'),
                //         ),
                //       ],
                //     );
                //   },
                // );

                // Retrieve and show the network logs
                logs = await NetworkLogger().retrieveLogsAsJson();
                setState(() {});
              } catch (e) {
                print('Error: $e');
              }
            },
            child: const Text('Hit API'),
          ),
          if (logs.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              itemCount: logs.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      'Status Code: ${logs[index]['statusCode']}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _getStatusCodeColor(logs[index]['statusCode']),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              'URL: ${logs[index]['url']}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Timestamp: ${logs[index]['timestamp']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Response Data: ${logs[index]['responseData']}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

Color _getStatusCodeColor(int statusCode) {
  if (statusCode >= 200 && statusCode < 300) {
    return Colors.green;
  } else if (statusCode >= 300 && statusCode < 400) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}
