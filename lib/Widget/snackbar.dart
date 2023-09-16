import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

showSnackBar(
    {required BuildContext context,
    required String message,
    bool error = false,
    int time = 1}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        overflow: TextOverflow.fade,
      ),
      backgroundColor: error ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: time),
    ),
  );
}

void vibrateDevice() {
  Vibration.vibrate(duration: 500); // Vibrate for 500 milliseconds
}
