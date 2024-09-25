import 'package:flutter/material.dart';
import 'package:tfk_toast/enum.dart';

/// A private widget class that handles the toast's animation and appearance.
///
/// This widget is responsible for building the animated toast content
/// and managing its lifecycle.
///
class AnimatedToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final Duration duration;
  final String? title;
  final bool showCloseIcon;
  final ToastAnimation animation;
  final VoidCallback onRemove;
  final TextStyle? messageStyle;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double elevation;
  final Widget? icon;
  final Color? backgroundColor;

  final VoidCallback? onTap;

  const AnimatedToastWidget({
    super.key,
    required this.message,
    required this.type,
    required this.duration,
    required this.onRemove,
    this.title,
    this.showCloseIcon = true,
    this.animation = ToastAnimation.none,
    this.messageStyle,
    this.titleStyle,
    this.padding,
    this.borderRadius = 8.0,
    this.elevation = 0.0,
    this.icon,
    this.onTap,
    this.backgroundColor,
  });

  @override
  AnimatedToastWidgetState createState() => AnimatedToastWidgetState();
}

class AnimatedToastWidgetState extends State<AnimatedToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _zoomAnimation;
  late Animation<double> _wobbleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );

    if (widget.animation == ToastAnimation.slide) {
      _slideAnimation = Tween<Offset>(
        begin: const Offset(0, -0.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ));
    } else if (widget.animation == ToastAnimation.fade) {
      _fadeAnimation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      );
    } else if (widget.animation == ToastAnimation.scale) {
      _scaleAnimation = Tween<double>(
        begin: 0.5,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ));
    } else if (widget.animation == ToastAnimation.bounce) {
      _bounceAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ));
    } else if (widget.animation == ToastAnimation.rotate) {
      _rotateAnimation = Tween<double>(
        begin: -0.5,
        end: 0.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
    } else if (widget.animation == ToastAnimation.zoom) {
      _zoomAnimation = Tween<double>(
        begin: 0.5,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
    }

    if (widget.animation == ToastAnimation.wobble) {
      _wobbleAnimation = Tween<double>(
        begin: -15.0,
        end: 15.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ));
    }

    _controller.forward();

    Future.delayed(widget.duration, () {
      _controller.reverse().then((_) {
        widget.onRemove();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget toastContent = GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? _getBackgroundColor(),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            if (widget.elevation > 0)
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, widget.elevation),
                blurRadius: widget.elevation,
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) widget.icon!,
            if (widget.icon != null) const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.title != null)
                    Text(
                      widget.title!,
                      style: widget.titleStyle ??
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                    ),
                  Text(
                    widget.message,
                    style: widget.messageStyle ??
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                  ),
                ],
              ),
            ),
            if (widget.showCloseIcon)
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  _controller.reverse().then((_) {
                    widget.onRemove();
                  });
                },
              ),
          ],
        ),
      ),
    );

    switch (widget.animation) {
      case ToastAnimation.slide:
        return SlideTransition(position: _slideAnimation, child: toastContent);
      case ToastAnimation.fade:
        return FadeTransition(opacity: _fadeAnimation, child: toastContent);
      case ToastAnimation.scale:
        return ScaleTransition(scale: _scaleAnimation, child: toastContent);
      case ToastAnimation.bounce:
        return SizeTransition(
            sizeFactor: _bounceAnimation, child: toastContent);
      case ToastAnimation.rotate:
        return RotationTransition(turns: _rotateAnimation, child: toastContent);
      case ToastAnimation.zoom:
        return ScaleTransition(scale: _zoomAnimation, child: toastContent);
      case ToastAnimation.wobble:
        return AnimatedBuilder(
          animation: _wobbleAnimation,
          builder: (context, child) {
            final value = _wobbleAnimation.value;
            return Transform.translate(
              offset: Offset(value, 0),
              child: child,
            );
          },
          child: toastContent,
        );
      case ToastAnimation.none:
      default:
        return toastContent;
    }
  }

  /// Returns the background color for the toast based on the [type] enum.
  ///
  /// * [type] : The type of toast, which determines its background color.
  ///
  /// Returns a `Color` that represents the background color of the toast.
  Color _getBackgroundColor() {
    switch (widget.type) {
      case ToastType.info:
        return Colors.blue;
      case ToastType.warning:
        return Colors.orange;
      case ToastType.error:
        return Colors.red;
      case ToastType.success:
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
