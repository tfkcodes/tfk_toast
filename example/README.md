# TfkToast

**TfkToast** is a Flutter package designed to display beautiful and customizable toast notifications. Toast messages provide non-intrusive feedback to users, enhancing their experience.

## Features

- **Customizable Toasts**: Display toasts with various types (info, warning, error, success).
- **Customizable Title and Message**: Add a title and message to your toast notifications.
- **Automatic Dismissal**: Toasts automatically disappear after a few seconds.
- **Manual Dismissal**: Optionally, allow users to manually close the toast.

## Example and Demos

## Installation

Add `tfk_toast` to your `pubspec.yaml` file:

```yaml
dependencies:
  tfk_toast: ^0.0.3
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
