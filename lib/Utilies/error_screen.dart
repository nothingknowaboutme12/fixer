import 'package:fixer/Utilies/app_color.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  String error;
  ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MaterialColr.primaryColor,
      body: Center(
        child: Text(
          "$error Please restart the app",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
