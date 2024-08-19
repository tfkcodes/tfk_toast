import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'tfk_toast_method_channel.dart';

abstract class TfkToastPlatform extends PlatformInterface {
  TfkToastPlatform() : super(token: _token);

  static final Object _token = Object();

  static TfkToastPlatform _instance = MethodChannelTfkToast();

  static TfkToastPlatform get instance => _instance;

  static set instance(TfkToastPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }

  Future<void> showToast(String message) {
    throw UnimplementedError('showToast() has not been implemented.');
  }
}
