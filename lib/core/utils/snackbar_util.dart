import 'package:flutter/material.dart';
import 'package:hui_application/main.dart';

void showGlobalErrorSnackBar(String message) {
  scaffoldMessengerKey.currentState!.clearSnackBars();
  scaffoldMessengerKey.currentState!.showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(16),
    ),
  );
}
