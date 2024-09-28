import 'package:flutter/material.dart';

import 'enum.dart';

class ToastEntry {
  final String message;
  final ToastType type;
  final ToastPosition position;
  final Duration duration;
  final String? title;
  final bool showCloseIcon;
  final ToastAnimation animation;
  final TextStyle? messageStyle;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double elevation;
  final Widget? icon;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final double? progress;
  final bool isCircularProgress;

  ToastEntry({
    required this.message,
    required this.type,
    required this.position,
    required this.duration,
    this.title,
    this.showCloseIcon = true,
    this.animation = ToastAnimation.none,
    this.messageStyle,
    this.titleStyle,
    this.padding,
    this.borderRadius = 8.0,
    this.elevation = 0.0,
    this.icon,
    this.backgroundColor,
    this.onTap,
    this.progress,
    this.isCircularProgress = false,
  });
}
