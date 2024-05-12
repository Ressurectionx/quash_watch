# QuashWatch

QuashWatch is a versatile Flutter plugin designed for efficient management of network and error logs in your applications. Seamlessly save and retrieve network logs, monitor screens, and handle errors with ease.

Capture Network Activity: Gain deep insights into your app's network communication for debugging and performance optimization.
Monitor Screens: Keep a watchful eye on your UI's behavior for visual debugging.
Handle Errors Seamlessly: Log errors effortlessly and retrieve them for analysis, aiding in troubleshooting.

## Getting Started

Integrate and utilize the QuashWatch plugin effortlessly in your Flutter project with these simple steps.

### Installing

Incorporate the QuashWatch plugin into your project by following these straightforward instructions:

1 Add the QuashWatch dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  quash_watch: ^1.0.0
```

2 Run `flutter pub get` in your terminal to install the dependency.

3 Import the QuashWatch package in your Dart code:

```dart

import 'package:quash_watch/quash_watch.dart';

```

## Usage

Efficiently utilize QuashWatch's powerful features to manage network activity, monitor screens, and handle errors within your Flutter application.

### Capturing Network Activity

Effortlessly capture and manage network activity with QuashWatch's versatile logging capabilities.

#### saveNetworkLogs

Save detailed network logs to monitor communication and analyze performance.

```dart
await QuashWatch().saveNetworkLogs({
  'timestamp': DateTime.now().toString(),
  'url': 'https://example.com/api',
  'statusCode': 200,
  'response': {'message': 'Success'},
});
```

#### Integration with Dio

Seamlessly integrate QuashWatch with Dio for enhanced monitoring and logging of HTTP requests.

```dart
dio.interceptors.add(QuashNetworkWatch());
```

### Retrieving Network Logs

Retrieve and analyze network logs to gain insights into your application's behavior and performance.

```dart

String networkLogs = await QuashWatch().retrieveNetworkLogs();
print(networkLogs);

```

### Monitoring Screens

Monitor screens within your application to track user interactions and behavior effectively.

```dart

await QuashWatch().watchScreen(MyScreen());

```

### Logging Errors

Efficiently log errors occurring within your application to facilitate debugging and analysis.

```dart

await QuashWatch().logError('An error occurred');

```

### Retrieving Error Logs

Retrieve and analyze error logs to diagnose issues and optimize your application's reliability.

```dart

List<Map<String, dynamic>> errorLogs = await QuashWatch().loadErrorLogs();
print(errorLogs);

```

### Loading Error Logs as Crash Data

Load error logs as crash data to gain deeper insights into application crashes and exceptions.

```dart

List<LogEntry> crashData = await QuashWatch().loadErrorLogsAsCrashData();
print(crashData);

```

With QuashWatch, managing network and error logs in your Flutter application has never been easier. Incorporate these powerful features to streamline development and enhance reliability.
