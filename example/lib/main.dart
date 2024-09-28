import 'package:flutter/material.dart';
import 'package:tfk_toast/enum.dart';
import 'package:tfk_toast/tfk_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /***********  INITIALIZE THE TOAST KEY HERE */
      navigatorKey: TfkToast.navigatorKey, //
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Toast Example'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("SIMPLE TOAST POSTIONS EXAMPLE"),
              Builder(builder: (context) {
                return Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [
                    /*********  TOP TOAST EXAMPLE *******/
                    ElevatedButton(
                      onPressed: () {
                        TfkToast.showToast(
                          "This is an toast title message!",
                          title: "Toast Title",
                          position: ToastPosition.top,
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.pinkAccent,
                          showIndicator: true,
                        );
                      },
                      child: const Text("Top Toast"),
                    ),
                    /*********  BOTTOM TOAST EXAMPLE *******/
                    ElevatedButton(
                      onPressed: () {
                        TfkToast.showToast(
                          "This is an toast title message!",
                          title: "Toast Title",
                          type: ToastType.info,
                          position: ToastPosition.bottom,
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                        );
                      },
                      child: const Text("Bottom Toast"),
                    ),
                    /*********  CENTER TOAST EXAMPLE *******/
                    ElevatedButton(
                      onPressed: () {
                        TfkToast.showToast(
                          "This is an toast title message!",
                          title: "Toast Title",
                          type: ToastType.info,
                          position: ToastPosition.center,
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                        );
                      },
                      child: const Text("Center Toast"),
                    )
                  ],
                );
              }),
              const Divider(),
              const Text(
                "SIMPLE TOAST ANIMATION EXAMPLE",
                style: TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.bold),
              ),
              Builder(builder: (context) {
                return Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [
                    /*********  TOP TOAST FADE ANIMATION EXAMPLE *******/
                    ElevatedButton(
                      onPressed: () {
                        TfkToast.showToast(
                          "This is an toast title message!",
                          title: "Toast Title",
                          type: ToastType.warning,
                          position: ToastPosition.top,
                          animation: ToastAnimation.fade,
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                        );
                      },
                      child: const Text("Fade Toast"),
                    ),
                    /*********  TOP TOAST SCALE ANIMATIOLN EXAMPLE *******/
                    ElevatedButton(
                      onPressed: () {
                        TfkToast.showToast(
                          "This is an toast title message!",
                          title: "Toast Title",
                          type: ToastType.warning,
                          position: ToastPosition.top,
                          animation: ToastAnimation.scale,
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                        );
                      },
                      child: const Text("Scale Toast"),
                    ),
                    /*********  TOP TOAST BOUNCE EXAMPLE *******/
                    ElevatedButton(
                      onPressed: () {
                        TfkToast.showToast(
                          "This is an toast title message!",
                          title: "Toast Title",
                          type: ToastType.warning,
                          position: ToastPosition.top,
                          animation: ToastAnimation.bounce,
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                        );
                      },
                      child: const Text("Bounce Toast"),
                    ),

                    /*********  TOP TOAST SLIDE EXAMPLE *******/
                    ElevatedButton(
                      onPressed: () {
                        TfkToast.showToast(
                          "This is an toast title message!",
                          title: "Toast Title",
                          type: ToastType.warning,
                          position: ToastPosition.top,
                          animation: ToastAnimation.slide,
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                        );
                      },
                      child: const Text("Slide Toast"),
                    ),
                    /*********  TOP TOAST WOBBLE EXAMPLE *******/
                    ElevatedButton(
                      onPressed: () {
                        TfkToast.showToast(
                          "This is an toast title message!",
                          title: "Toast Title",
                          type: ToastType.warning,
                          position: ToastPosition.top,
                          animation: ToastAnimation.wobble,
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                        );
                      },
                      child: const Text("Wobble Toast"),
                    ),
                    /*********  TOP TOAST ROTATE EXAMPLE *******/
                    ElevatedButton(
                      onPressed: () {
                        TfkToast.showToast(
                          "This is an toast title message!",
                          title: "Toast Title",
                          type: ToastType.warning,
                          position: ToastPosition.top,
                          animation: ToastAnimation.rotate,
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                        );
                      },
                      child: const Text("Rotate Toast"),
                    )
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
