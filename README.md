# QuashWatch

The QuashWatch is a powerful tool for managing network and error logs in your Flutter applications. With this plugin, you can easily save and retrieve network logs, monitor screens, and handle error logs seamlessly.

## Getting Started

These instructions will guide you through setting up and using the QuashWatch plugin in your Flutter project.

### Installing

##### To use the QuashWatch plugin in your Flutter project, follow these steps:

Add the following dependency to your pubspec.yaml file:

```
dependencies:
  quash_watch: ^1.0.0

```

Run the following command in your terminal to install the dependency:

```

flutter pub get

```

Import the QuashWatch package in your Dart code:

```

import 'package:quash_watch/quash_watch.dart';

```

## Usage

### Capturing Network Activity

##### To save network logs, use the saveNetworkLogs method or Dio's interceptor method:

The saveNetworkLogs method allows you to effortlessly capture details about your application's network requests. This information can be invaluable for debugging communication issues and analyzing performance.

```

await QuashWatch().saveNetworkLogs({
  'timestamp': DateTime.now().toString(),
  'url': 'https://example.com/api',
  'statusCode': 200,
  'response': {'message': 'Success'},
});

```

##### Integration with Dio:

If you're utilizing the Dio package for HTTP communication in your Flutter project, QuashWatch offers a seamless integration approach. Simply add an instance of QuashNetworkWatch to your Dio's interceptor list:

```

// Integrate QuashWatch with Dio
dio.interceptors.add(QuashNetworkWatch());

```

### Retrieving Network Logs

##### To retrieve network logs, use the retrieveNetworkLogs method:
