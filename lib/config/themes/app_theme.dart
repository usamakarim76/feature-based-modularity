import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/core/extensions/responsive_extensions.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins', // ✅ Set global font family
    scaffoldBackgroundColor: AppColorLight.background,
    primaryColor: AppColorLight.primary,
    iconTheme: const IconThemeData(color: AppColorLight.primary),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColorLight.background,
      iconTheme: const IconThemeData(color: AppColorLight.primary),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColorLight.primary,
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        side: const BorderSide(color: AppColorLight.disabledButton),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColorLight.fontTitle, fontSize: 18.sp),
      bodyMedium: TextStyle(color: AppColorLight.fontSubtitle, fontSize: 16.sp),
      bodySmall: TextStyle(color: AppColorLight.fontSubtitle, fontSize: 14.sp),
      titleLarge: TextStyle(
        color: AppColorLight.primary,
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(10),
      fillColor: AppColorLight.whiteSmoke,
      filled: true,
      hintStyle: TextStyle(color: AppColorLight.filled),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColorLight.divider),
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins', // ✅ Set global font family
    scaffoldBackgroundColor: AppColorDark.background,
    primaryColor: AppColorDark.primary,
    iconTheme: const IconThemeData(color: AppColorDark.primary),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColorDark.background,
      iconTheme: const IconThemeData(color: AppColorDark.primary),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColorDark.primary,
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        side: const BorderSide(color: AppColorDark.disabledButton),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColorDark.fontTitle, fontSize: 18.sp),
      bodyMedium: TextStyle(color: AppColorDark.fontSubtitle, fontSize: 16.sp),
      bodySmall: TextStyle(color: AppColorDark.fontSubtitle, fontSize: 14.sp),
      titleLarge: TextStyle(
        color: AppColorDark.primary,
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorDark.card,
      hintStyle: TextStyle(color: AppColorDark.fontSubtitle),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColorDark.divider),
      ),
    ),
  );
}
