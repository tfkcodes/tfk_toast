import 'package:flutter/material.dart';

enum ToastType { info, warning, error, success }

enum ToastPosition { top, center, bottom }

class TfkToast {
  static showToast(
    BuildContext context,
    String message,
    ToastType type, {
    ToastPosition position = ToastPosition.top,
  }) {
    double topPosition;
    switch (position) {
      case ToastPosition.top:
        topPosition = 50.0;
        break;
      case ToastPosition.center:
        topPosition = MediaQuery.of(context).size.height / 2 - 50.0;
        break;
      case ToastPosition.bottom:
        topPosition = MediaQuery.of(context).size.height - 150.0;
        break;
    }

    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: topPosition,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: _CustomToastWidget(message: message, type: type),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}

class _CustomToastWidget extends StatelessWidget {
  final String message;
  final ToastType type;

  const _CustomToastWidget({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  Color _getBackgroundColor() {
    switch (type) {
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

  IconData _getIcon() {
    switch (type) {
      case ToastType.info:
        return Icons.info;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.error:
        return Icons.error;
      case ToastType.success:
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_getIcon(), color: Colors.white),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
