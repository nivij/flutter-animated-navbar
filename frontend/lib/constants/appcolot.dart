import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFFFFFF6);
  static const Color primarybuttonColor = Color(0xFF81dd59);
  static const Color primarybuttontextColor = Colors.white;
  static const Color backgroundColor = Color(0xFF080808);
  static const Color offwhitetabbackgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF333333);
  static const Color accentColor = Color(0xFFFCF6DA);

  // Define gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
    colors: [
      Color(0xFFFFFFF6),
      Color(0xFFFCF6DA),
    ],
  );
}
