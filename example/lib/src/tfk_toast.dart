import 'package:flutter/material.dart';

enum ToastType { info, warning, error, success }

enum ToastPosition { top, center, bottom }

enum ToastAnimation { none, slide, fade, scale, bounce, rotate, zoom, wobble }

class TfkToast {
  static showToast(
    BuildContext context,
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
          child: _AnimatedToastWidget(
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
            onTap: onTap,
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }

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

class _AnimatedToastWidget extends StatefulWidget {
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
  final VoidCallback? onTap;

  const _AnimatedToastWidget({
    Key? key,
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
  }) : super(key: key);

  @override
  _AnimatedToastWidgetState createState() => _AnimatedToastWidgetState();
}

class _AnimatedToastWidgetState extends State<_AnimatedToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _zoomAnimation;
  late Animation<double> _flipAnimation;
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

    Future.delayed(Duration(seconds: 2), () {
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
          color: _getBackgroundColor(),
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
