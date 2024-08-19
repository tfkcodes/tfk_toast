import 'package:flutter/material.dart';
import 'package:tfk_toast_example/src/tfk_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom Toast Example')),
        body: Center(
          child: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  TfkToast.showToast(context, "This is an error message!",
                      title: "Error",
                      position: ToastPosition.top,
                      animation: ToastAnimation.scale,
                      type: ToastType.info,
                      icon: const Icon(
                        Icons.info,
                        color: Colors.white,
                      ));
                },
                child: const Text('Show Error Toast'),
              );
            },
          ),
        ),
      ),
    );
  }
}
