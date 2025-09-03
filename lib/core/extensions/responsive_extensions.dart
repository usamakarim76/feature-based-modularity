import 'package:clean_architecture/config/responsive/responsive_config.dart';
import 'package:flutter/widgets.dart';

/// Extension on `num` to provide responsive sizing helpers
extension ResponsiveNum on num {
  /// Convert a number to a responsive height value
  /// Example: `20.h` → returns height adjusted for current device
  double get h => ResponsiveConfig.height(toDouble());

  /// Convert a number to a responsive width value
  /// Example: `15.w` → returns width adjusted for current device
  double get w => ResponsiveConfig.width(toDouble());

  /// Convert a number to a responsive font size (scale)
  /// Example: `14.sp` → returns font size adjusted for current device
  double get sp => ResponsiveConfig.scale(toDouble());

  /// Create a vertical space (SizedBox) with responsive height
  /// Example: `10.ht` → returns `SizedBox(height: adjustedHeight)`
  SizedBox get ht => SizedBox(height: ResponsiveConfig.height(toDouble()));

  /// Create a horizontal space (SizedBox) with responsive width
  /// Example: `8.wt` → returns `SizedBox(width: adjustedWidth)`
  SizedBox get wt => SizedBox(width: ResponsiveConfig.width(toDouble()));
}

/// Extension on BuildContext to quickly access screen size info
extension ScreenSize on BuildContext {
  /// Get the current screen height
  double get sh => MediaQuery.of(this).size.height;

  /// Get the current screen width
  double get sw => MediaQuery.of(this).size.width;

  /// Check if the current device is a tablet
  bool get isTablet => ResponsiveConfig.isTablet;

  /// Get the current screen orientation (portrait/landscape)
  Orientation get orientation => ResponsiveConfig.orientation;
}
