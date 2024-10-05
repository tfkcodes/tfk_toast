# TfkToast

[![pub package](https://img.shields.io/pub/v/tfk_toast.svg)](https://pub.dev/packages/seamless_data_sync)
[![GitHub issues](https://img.shields.io/github/issues/tfkcodes/tfk_toast)](https://github.com/tfkcodes/tfk_toast/issues)
[![GitHub stars](https://img.shields.io/github/stars/tfkcodes/tfk_toast)](https://github.com/tfkcodes/tfk_toast/stargazers)
[![GitHub license](https://img.shields.io/github/license/tfkcodes/tfk_toast)](https://github.com/tfkcodes/tfk_toast/blob/main/LICENSE)

**TfkToast** is a Flutter package designed to display beautiful and customizable toast notifications. Toast messages provide non-intrusive feedback to users, enhancing their experience.

## Features

- **Customizable Toasts**: Display toasts with various types (info, warning, error, success).
- **Customizable Title and Message**: Add a title and message to your toast notifications.
- **Automatic Dismissal**: Toasts automatically disappear after a few seconds.
- **Manual Dismissal**: Optionally, allow users to manually close the toast.

![Video Preview](example/assets/demos/demo1.gif)

## Installation

Add `tfk_toast` to your `pubspec.yaml` file:

```yaml
dependencies:
  tfk_toast: ^0.2.2
```

Then run:

```dart
   flutter pub get
```

## Usage

Import the package in your Dart file:

```dart
import 'package:tfk_toast/tfk_toast.dart';
```

To show a toast, use the following code:

### INITILIALIZE THE PACKAGE TO REMOVE passing context direct the package

```dart
  class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  /****\*\*\***** INITIALIZE THE TOAST KEY HERE \*/
  navigatorKey: TfkToast.navigatorKey, //
  home: Scaffold(
  appBar: AppBar(
  title: const Text('Custom Toast Example'),
  backgroundColor: Colors.blue,
       ),
     ),
   );
 }
}

```

```dart
TfkToast.showToast("This is an toast title message!",
      title: "Toast Title",
      position: ToastPosition.top,
      icon: const Icon(
      Icons.info,
      color: Colors.white,
      ),
      backgroundColor: Colors.pinkAccent
);
```
