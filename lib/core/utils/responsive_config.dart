import 'package:flutter/material.dart';

class ResponsiveConfig {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
  }
}
