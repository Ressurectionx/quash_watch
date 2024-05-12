class NetworkLogEntry {
  final String timestamp;
  final String url;
  final int statusCode;
  final Map<String, dynamic> responseData;

  NetworkLogEntry({
    required this.timestamp,
    required this.url,
    required this.statusCode,
    required this.responseData,
  });

  factory NetworkLogEntry.fromJson(Map<String, dynamic> json) {
    return NetworkLogEntry(
      timestamp: json['timestamp'],
      url: json['url'],
      statusCode: json['statusCode'],
      responseData: json['responseData'],
    );
  }
}
