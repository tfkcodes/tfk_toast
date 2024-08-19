import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tfk_toast_method_channel.dart';

abstract class TfkToastPlatform extends PlatformInterface {
  /// Constructs a TfkToastPlatform.
  TfkToastPlatform() : super(token: _token);

  static final Object _token = Object();

  static TfkToastPlatform _instance = MethodChannelTfkToast();

  /// The default instance of [TfkToastPlatform] to use.
  ///
  /// Defaults to [MethodChannelTfkToast].
  static TfkToastPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TfkToastPlatform] when
  /// they register themselves.
  static set instance(TfkToastPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
