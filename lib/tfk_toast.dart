import 'package:flutter/material.dart';

enum ToastType { info, warning, error, success }

class TfkToast {
  static showToast(BuildContext context, String message, ToastType type) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0,
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

  const _CustomToastWidget(
      {Key? key, required this.message, required this.type})
      : super(key: key);

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
