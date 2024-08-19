import 'package:flutter/material.dart';
import 'package:tfk_toast/tfk_toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('TFK Toast Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              TfkToast.showToast('Hello from TfkToast!');
            },
            child: Text('Show Toast'),
          ),
        ),
      ),
    );
  }
}
