import 'package:flutter/material.dart';

extension TextThemeExtension on BuildContext {
  /// Access the current [TextTheme] from the context
  TextTheme get _textTheme => Theme.of(this).textTheme;

  /// Display Large - FontWeight.w800, 28.sp
  TextStyle? get displayLarge => _textTheme.displayLarge;

  /// Display Medium - FontWeight.w700, 26.sp
  TextStyle? get displayMedium => _textTheme.displayMedium;

  /// Display Small - FontWeight.w600, 24.sp
  TextStyle? get displaySmall => _textTheme.displaySmall;

  /// Title Large - FontWeight.w700, 20.sp
  TextStyle? get titleLarge => _textTheme.titleLarge;

  /// Title Medium - FontWeight.w600, 18.sp
  TextStyle? get titleMedium => _textTheme.titleMedium;

  /// Title Small - FontWeight.w500, 16.sp
  TextStyle? get titleSmall => _textTheme.titleSmall;

  /// Body Large - (default w500), 14.sp
  TextStyle? get bodyLarge => _textTheme.bodyLarge;

  /// Body Medium - FontWeight.w400, 12.sp
  TextStyle? get bodyMedium => _textTheme.bodyMedium;

  /// Body Small - FontWeight.w300, 10.sp
  TextStyle? get bodySmall => _textTheme.bodySmall;
}
