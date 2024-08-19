import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tfk_toast_platform_interface.dart';

/// An implementation of [TfkToastPlatform] that uses method channels.
class MethodChannelTfkToast extends TfkToastPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tfk_toast');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
