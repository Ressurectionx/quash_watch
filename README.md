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
(This plugin is currently unpublished, so please clone it and provide the path in your other project.)

```yaml
dependencies:
  quash_watch:
    path: /Users/Username/projects/quash_watch
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

##### saveNetworkLogs

Save detailed network logs to monitor communication and analyze performance.

```dart
  final QuashWatch _quashWatch = QuashWatch();

   _quashWatch.saveNetworkLogs({
        'timestamp': DateTime.now().toIso8601String(),
        'url': response.requestOptions.uri.toString(),
        'statusCode': response.statusCode,
        'responseData': json.decode(response.toString()),
      });
```

##### Integration with Dio

Seamlessly integrate QuashWatch with Dio for enhanced monitoring and logging of HTTP requests.

```dart
  dio.interceptors.add(QuashNetworkWatch());
```

##### Retrieving Network Logs

Retrieve and analyze network logs to gain insights into your application's behavior and performance.

```dart
  final QuashWatch _quashWatch = QuashWatch();

  String networkLogs = await _quashWatch.retrieveNetworkLogs();
  print(networkLogs);
```

### Monitoring Screens

Monitor screens within your application to track user interactions and behavior effectively.
Its very simple to use this feature just wrap your widget with QuashScreenWatch

```dart

  QuashScreenWatch(child: YourWidget())

```

### Handling Crash Reports

QuashWatch provides a convenient feature for handling crash reports within your Flutter application. By logging errors and exceptions, you can effectively monitor and analyze application crashes to diagnose issues and optimize reliability.

##### Logging Crash Reports

just add this line in your main method and it will do remaining work for you

```dart
  QuashWatch quash = QuashWatch();

  FlutterError.onError = (FlutterErrorDetails details) async {
    await quash.handleErrors();
  };

```

##### Retrieving Crash Reports:

To get crash report and show it on your screen you can use following code

```dart

Future<List<LogEntry>> loadErrorLogsAsCrashData() async {
  return await quashWatch.loadErrorLogsAsCrashData();
}

```

.
