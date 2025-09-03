import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/core/extensions/textstyle_extension.dart';
import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  /// Shows a **success** SnackBar with a green background.
  ///
  /// - `message`: The text to display.
  /// - `duration`: How long the SnackBar stays visible (default: 1 second).
  void showSuccessSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: bodySmall?.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        // padding: EdgeInsets.symmetric(vertical: 20.h),
        // margin: EdgeInsets.only(bottom: sh - 100, left: 20, right: 20),
        // elevation: 30,
      ),
    );
  }

  /// Shows an **error** SnackBar with a red background.
  ///
  /// - `message`: The text to display.
  /// - `duration`: How long the SnackBar stays visible (default: 1 second).
  void showErrorSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 1),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: bodyLarge?.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        // padding: EdgeInsets.symmetric(vertical: 20.h),
        // margin: EdgeInsets.only(bottom: sh - 100, left: 20, right: 20),
        // elevation: 30,
      ),
    );
  }
}
