import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'quash_watch_platform_interface.dart';

/// An implementation of [QuashWatchPlatform] that uses method channels.
class MethodChannelQuashWatch extends QuashWatchPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('quash_watch');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
