import 'package:flutter/material.dart';

class MQ {
  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static double _textScaleFactor = 1;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
  static double get textScaleFactor => _textScaleFactor;

  // Helpers
  static double width(double fraction) => _screenWidth * fraction;
  static double height(double fraction) => _screenHeight * fraction;
  static double scaledFont(double size) => size * _textScaleFactor;
}
