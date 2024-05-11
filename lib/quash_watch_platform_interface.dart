import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'quash_watch_method_channel.dart';

abstract class QuashWatchPlatform extends PlatformInterface {
  /// Constructs a QuashWatchPlatform.
  QuashWatchPlatform() : super(token: _token);

  static final Object _token = Object();

  static QuashWatchPlatform _instance = MethodChannelQuashWatch();

  /// The default instance of [QuashWatchPlatform] to use.
  ///
  /// Defaults to [MethodChannelQuashWatch].
  static QuashWatchPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [QuashWatchPlatform] when
  /// they register themselves.
  static set instance(QuashWatchPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
