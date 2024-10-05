package com.tfkpackages.tfktost

import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class TfkToastPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: android.content.Context  // Store the context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "tfk_toast")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext // Save the application context
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "showToast") {
      val message = call.argument<String>("message")
      if (message != null) {
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show()  // Use the saved context
        result.success(null)
      } else {
        result.error("INVALID_ARGUMENT", "Message is null", null)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
