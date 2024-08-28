import 'package:flutter/material.dart';

import 'widgets/animation_widget.dart';

/// Represents the different types of toast notifications.
///
/// Each type typically corresponds to a specific color or style.
enum ToastType {
  /// An informational toast, typically with a blue background.
  info,

  /// A warning toast, typically with an orange background.
  warning,

  /// An error toast, typically with a red background.
  error,

  /// A success toast, typically with a green background.
  success
}

/// Defines the position on the screen where the toast will be displayed.
enum ToastPosition {
  /// Positions the toast at the top of the screen.
  top,

  /// Positions the toast at the center of the screen.
  center,

  /// Positions the toast at the bottom of the screen.
  bottom
}

/// Represents the animation type to be used when displaying the toast.
enum ToastAnimation {
  /// No animation.
  none,

  /// Slides the toast into view.
  slide,

  /// Fades the toast into view.
  fade,

  /// Scales the toast from a smaller size to its final size.
  scale,

  /// Bounces the toast into view.
  bounce,

  /// Rotates the toast into view.
  rotate,

  /// Zooms the toast from a smaller size to its final size.
  zoom,

  /// Wobbles the toast from side to side as it appears.
  wobble
}

/// A utility class to display customizable toast notifications in a Flutter app.
///
/// The `TfkToast` class provides a static method `showToast` that allows you
/// to display toast messages with various customization options, including type,
/// position, animation, duration, and more.
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
  }) {
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: _getPosition(context, position),
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: AnimatedToastWidget(
            message: message,
            type: type,
            duration: duration,
            title: title,
            showCloseIcon: showCloseIcon,
            animation: animation,
            onRemove: () => overlayEntry!.remove(),
            messageStyle: messageStyle,
            titleStyle: titleStyle,
            padding: padding,
            borderRadius: borderRadius,
            elevation: elevation,
            icon: icon,
            backgroundColor: backgroundColor,
            onTap: onTap,
          ),
        ),
      ),
    );

    // Overlay.of(context).insert(overlayEntry);
    navigatorKey.currentState!.overlay!.insert(overlayEntry);
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
