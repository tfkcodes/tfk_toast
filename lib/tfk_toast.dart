import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tfk_toast/animation_widget.dart';

import 'package:tfk_toast/enum.dart';
import 'package:tfk_toast/toast_queue.dart';

class TfkToast {
  /// Displays a custom toast notification.
  ///
  /// The toast message will be shown with the specified parameters, allowing
  /// for a high degree of customization.
  ///
  /// * [context] : The `BuildContext` in which to show the toast.
  /// * [message] : The main message of the toast.
  /// * [type] : The type of toast, determining the color and style.
  /// * [position] : The position on the screen where the toast will appear.
  /// * [duration] : The duration for which the toast will be visible.
  /// * [title] : An optional title for the toast, displayed above the message.
  /// * [showCloseIcon] : Whether to show a close icon on the toast.
  /// * [animation] : The animation used when showing and hiding the toast.
  /// * [messageStyle] : Custom text style for the message.
  /// * [titleStyle] : Custom text style for the title.
  /// * [padding] : Padding around the toast content.
  /// * [borderRadius] : The border radius of the toast container.
  /// * [elevation] : The elevation (shadow) of the toast container.
  /// * [icon] : An optional icon to display alongside the message.
  /// * [onTap] : A callback that triggers when the toast is tapped.
  ///   /// * [backgroundColor] : The background color of the toast. Defaults to the color based on the [type].

  static final navigatorKey = GlobalKey<NavigatorState>();
  // Toast queue
  static final Queue<ToastEntry> _toastQueue = Queue<ToastEntry>();

// Flag to track if a toast is currently active
  static bool _isToastActive = false;

  static showToast(
    String message, {
    ToastType type = ToastType.info,
    ToastPosition position = ToastPosition.top,
    Duration duration = const Duration(seconds: 2),
    String? title,
    bool showCloseIcon = true,
    ToastAnimation animation = ToastAnimation.none,
    TextStyle? messageStyle,
    TextStyle? titleStyle,
    EdgeInsetsGeometry? padding,
    double borderRadius = 8.0,
    double elevation = 0.0,
    Widget? icon,
    Color? backgroundColor,
    VoidCallback? onTap,
    double? progress,
    bool showIndicator = false,
  }) {
    _toastQueue.add(ToastEntry(
      message: message,
      type: type,
      position: position,
      duration: duration,
      title: title,
      showCloseIcon: showCloseIcon,
      animation: animation,
      messageStyle: messageStyle,
      titleStyle: titleStyle,
      padding: padding,
      borderRadius: borderRadius,
      elevation: elevation,
      icon: icon,
      backgroundColor: backgroundColor,
      onTap: onTap,
      progress: progress,
      showIndicator: showIndicator,
    ));

    // If no toast is active, show the next toast
    if (!_isToastActive) {
      _showNextToast();
    }
  }

  // Show the next toast in the queue
  static void _showNextToast() {
    if (_toastQueue.isNotEmpty) {
      final toast = _toastQueue.removeFirst();
      _isToastActive = true;

      late OverlayEntry overlayEntry;
      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: _getPosition(context, toast.position),
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
          child: Material(
            color: Colors.transparent,
            child: AnimatedToastWidget(
              message: toast.message,
              type: toast.type,
              duration: toast.duration,
              title: toast.title,
              showCloseIcon: toast.showCloseIcon,
              animation: toast.animation,
              onRemove: () {
                overlayEntry.remove();
                _isToastActive = false;
                _showNextToast();
              },
              messageStyle: toast.messageStyle,
              titleStyle: toast.titleStyle,
              padding: toast.padding,
              borderRadius: toast.borderRadius,
              elevation: toast.elevation,
              icon: toast.icon,
              backgroundColor: toast.backgroundColor,
              onTap: toast.onTap,
              progress: toast.progress,
              isProgress: toast.showIndicator,
            ),
          ),
        ),
      );

      navigatorKey.currentState!.overlay!.insert(overlayEntry);

      // Remove the toast after the duration
      Future.delayed(toast.duration, () {
        if (_isToastActive) {
          overlayEntry.remove();
          _isToastActive = false;
          _showNextToast(); // Show the next toast
        }
      });
    }
  }

  /// Returns the vertical position of the toast based on the [position] enum.
  ///
  /// * [context]: The `BuildContext` of the widget.
  /// * [position]: The desired position of the toast on the screen.
  ///
  /// Returns a `double` indicating the top position for the `Positioned` widget.
  static double _getPosition(BuildContext context, ToastPosition position) {
    switch (position) {
      case ToastPosition.top:
        return 50.0;
      case ToastPosition.center:
        return MediaQuery.of(context).size.height / 2 - 50.0;
      case ToastPosition.bottom:
        return MediaQuery.of(context).size.height - 150.0;
      default:
        return 50.0;
    }
  }
}
