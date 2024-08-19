import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'tfk_toast_platform_interface.dart';

class MethodChannelTfkToast extends TfkToastPlatform {
  // Define the method channel with the name used in the native code.
  @visibleForTesting
  final methodChannel = const MethodChannel('tfk_toast');

  @override
  Future<void> showToast(String message) async {
    try {
      // Invoke the 'showToast' method on the native side with the message as an argument.
      await methodChannel.invokeMethod('showToast', {'message': message});
    } on PlatformException catch (e) {
      // Handle platform-specific exceptions.
      if (kDebugMode) {
        print("Failed to show toast: '${e.message}'.");
      }
    }
  }

  @override
  Future<String?> getPlatformVersion() async {
    try {
      // Invoke the 'getPlatformVersion' method on the native side.
      final version =
          await methodChannel.invokeMethod<String>('getPlatformVersion');
      return version;
    } on PlatformException catch (e) {
      // Handle platform-specific exceptions.
      if (kDebugMode) {
        print("Failed to get platform version: '${e.message}'.");
      }
      return null;
    }
  }
}
