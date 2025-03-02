import 'package:flutter/material.dart';

void showCustomSnackBar({
  Color? bgColor,
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      backgroundColor: bgColor ?? Colors.black, // Default color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin:
          EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Floating effect
    ),
  );
}
