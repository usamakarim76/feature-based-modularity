import 'package:flutter/material.dart';

// class AppColors {
//   static const primary = Color(0xFF0066FF);
//   static const secondary = Color(0xFFFFC107);
//   static const background = Color(0xFFF5F5F5);
//   static const textPrimary = Color(0xFF212121);
//   static const error = Color(0xFFB00020);
//   static const white = Color(0xFFFFFFFF);
//   static const black = Color(0xFF000000);
//   static const success = Color(0xFF4CAF50);
//   static const failure = Color(0xFFD32F2F);
//   static const transparent = Color(0x00000000);
//   static const grey = Color(0xFFBDBDBD);

//   // Add more colors as needed
// }

class AppColorLight {
  static const Color primary = Color(0xFF000000);
  static const Color background = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFD9D9D9);
  static const Color disabledButton = Color(0xFFC3C3C3);
  static const Color fontTitle = Color(0xFF588F12);
  static const Color card = Color(0xFFF5F5F5);
  static const Color fontSubtitle = Color(0xFF5B5A5A);
  static const Color fontDisable = Color(0xFFD9D9D9);
  static const Color filled = Color(0xFFF9F8F8);
  static const Color simpleFontColor = Color(0xFFA7A7A7);

  // static const Color fontDisable = Color(0xFFD9D9);
  ///not user in theme
  static const Color iconDisable = Color(0xFFC3C3C3);
  static const Color cardback = Color(0xFFBADAB0);
  static const Color textBlack = Color(0xFF404040);
  static const Color blue = Color(0xFF4066BA);
  static const Color redLight = Color(0xFFFFD7CF);

  static const Color success = Color(0xFF588F12);
  static const Color warning = Color(0xFFFFB74D);
  static const Color error = Color(0xFFA41212);
  static const Color info = Color(0xFF64B5F6);

  // Other
  static const Color silverTree = Color(0xFF5FB4A5);
  static const Color catSkillWhite = Color(0xFFF0F5F9);
  static const Color halfDutchWhite = Color(0xFFFFF6E1);
  static const Color whiteSmoke = Color(0xFFF3F4F8);
  static const Color linkWater = Color(0xFFDAE7F1);
  static const Color inputFill = Color(0xFFF2F2F2);
}

class AppColorDark {
  static const Color primary = Color(0xFF149CFC);
  static const Color background = Color(0xFF303030);
  static const Color card = Color(0xFF424242);
  static const Color fontTitle = Color(0xFFFFFFFF);
  static const Color fontSubtitle = Color(0xFFC1C1C1);
  static const Color fontDisable = Color(0xFF989898);
  static const Color disabledButton = Color(0xFF6E6E6E);
  static const Color divider = Color(0xFF494949);

  static const Color success = Color.fromARGB(255, 98, 249, 106);
  static const Color warning = Color(0xFFF57C00);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF1976D2);
  static const Color inputFill = Color(0xFF1E1E1E);
}

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF4CAF50); // Fresh Green
  static const Color primaryDark = Color(0xFF388E3C);
  static const Color primaryLight = Color(0xFF81C784);

  // Secondary Colors
  static const Color secondary = Color(0xFFFF9800); // Warm Orange
  static const Color secondaryDark = Color(0xFFE65100);
  static const Color secondaryLight = Color(0xFFFFB74D);

  // Accent Colors
  static const Color accent = Color(0xFFF44336); // Alert Red
  static const Color accentLight = Color(0xFFEF5350);

  // Background Colors
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textPrimaryDark = Color(0xFFE0E0E0);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textSecondaryDark = Color(0xFFBDBDBD);

  // Additional Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
