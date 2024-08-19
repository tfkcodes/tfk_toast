import 'package:flutter/material.dart';

enum ToastType { info, warning, error, success }

class ToastUtils {
  showToast(BuildContext context, String message, ToastType type,
      {String? title}) {
    final GlobalKey<_CustomToastWidgetState> key =
        GlobalKey<_CustomToastWidgetState>();
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: _CustomToastWidget(
            key: key,
            message: message,
            type: type,
            title: title,
            onClose: () {
              overlayEntry!.remove();
            },
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry!.remove();
    });
  }
}

class _CustomToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final String? title;
  final VoidCallback onClose;

  const _CustomToastWidget({
    Key? key,
    required this.message,
    required this.type,
    this.title,
    required this.onClose,
  }) : super(key: key);

  @override
  _CustomToastWidgetState createState() => _CustomToastWidgetState();
}

class _CustomToastWidgetState extends State<_CustomToastWidget> {
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

  IconData _getIcon() {
    switch (widget.type) {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(_getIcon(), color: Colors.white),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.title != null) ...[
                    Text(
                      widget.title!,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                  ],
                  Text(
                    widget.message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: widget.onClose,
          ),
        ],
      ),
    );
  }
}
