import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  // Add more custom extensions
}
