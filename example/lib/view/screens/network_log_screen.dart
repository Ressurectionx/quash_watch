import 'package:flutter/material.dart';
import '../../utils/helpers.dart';
import '../../controller/network_log_controller.dart';

class NetworkLogScreen extends StatefulWidget {
  const NetworkLogScreen({Key? key}) : super(key: key);

  @override
  _NetworkLogScreenState createState() => _NetworkLogScreenState();
}

class _NetworkLogScreenState extends State<NetworkLogScreen> {
  final NetworkLogController _controller = NetworkLogController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Log'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _controller.getNetworkLogs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final logs = snapshot.data ?? [];

              return Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  InkWell(
                    onTap: () async {
                      await _controller.hitAPI();
                      setState(() {});
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min, // Adjusts width to content
                          children: [
                            Text(
                              'Hit API',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  logs.isEmpty
                      ? const Center(child: Text('No logs found'))
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: logs.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ExpansionTile(
                                  title: Text(
                                    'Status Code: ${logs[index]['statusCode']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: getStatusCodeColor(
                                        logs[index]['statusCode'],
                                      ),
                                    ),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                        ),
                ],
              );
            }
          }),
    );
  }
}
