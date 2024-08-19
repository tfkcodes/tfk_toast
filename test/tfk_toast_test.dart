import 'package:flutter_test/flutter_test.dart';
import 'package:tfk_toast/tfk_toast.dart';
import 'package:tfk_toast/tfk_toast_platform_interface.dart';
import 'package:tfk_toast/tfk_toast_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTfkToastPlatform
    with MockPlatformInterfaceMixin
    implements TfkToastPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> showToast(String message) async {
    // Mock implementation for showToast
    return;
  }
}

void main() {
  final TfkToastPlatform initialPlatform = TfkToastPlatform.instance;

  test('$MethodChannelTfkToast is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTfkToast>());
  });

  test('getPlatformVersion', () async {
    TfkToast tfkToastPlugin = TfkToast();
    MockTfkToastPlatform fakePlatform = MockTfkToastPlatform();
    TfkToastPlatform.instance = fakePlatform;
  });

  test('showToast', () async {
    MockTfkToastPlatform fakePlatform = MockTfkToastPlatform();
    TfkToastPlatform.instance = fakePlatform;
  });
}
