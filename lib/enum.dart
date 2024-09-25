
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