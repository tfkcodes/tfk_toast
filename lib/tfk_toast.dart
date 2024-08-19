// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/services.dart';

import 'tfk_toast_platform_interface.dart';

class TfkToast {
  static const MethodChannel _channel = MethodChannel('tfk_toast');

  Future<String?> getPlatformVersion() {
    return TfkToastPlatform.instance.getPlatformVersion();
  }

  static Future<void> showToast(String message) async {
    await _channel.invokeMethod('showToast', {'message': message});
  }
}
