import 'package:clean_architecture/core/constants/app_logs.dart';
import 'package:flutter/material.dart';

/// A responsive configuration utility that helps adapt UI elements
/// to different screen sizes and orientations.
///
/// This class provides methods to scale dimensions proportionally
/// based on reference device sizes for both mobile and tablet.
class ResponsiveConfig {
  // Current device dimensions
  static late double screenWidth;
  static late double screenHeight;
  static late Orientation orientation;
  static late bool isTablet;

  // Reference dimensions for scaling calculations
  static late double mobileReferenceHeight;
  static late double mobileReferenceWidth;
  static late double tabletReferenceHeight;
  static late double tabletReferenceWidth;

  // Initialization flag
  static bool _initialized = false;

  // Logger instance for debug information
  static final AppLogger _appLogger = AppLogger(className: "ResponsiveConfig");

  /// Initializes the responsive configuration with device and reference sizes.
  ///
  /// @param context The BuildContext to access MediaQuery
  /// @param mobileSize Reference size for mobile devices
  ///        (default: 375x812 - iPhone 13/14 Pro portrait dimensions in points)
  ///        Note: This is the design size your UI was created for
  /// @param tabletSize Reference size for tablets
  ///        (default: 834x1194 - iPad Pro 11" portrait dimensions in points)
  ///        Note: This is the design size your tablet UI was created for
  /// @param isDebugPrint Whether to print initialization details
  /// @param customTabletCheck Optional custom function to determine tablet detection
  static void init(
    BuildContext context, {
    Size mobileSize = const Size(
      375,
      812,
    ), // Design size for mobile (iPhone 13/14 Pro)
    Size tabletSize = const Size(
      834,
      1194,
    ), // Design size for tablet (iPad Pro 11")
    bool isDebugPrint = false,
    bool Function(Size size)? customTabletCheck,
  }) {
    final size = MediaQuery.of(context).size;

    // Capture current device metrics
    screenWidth = size.width;
    screenHeight = size.height;
    orientation = MediaQuery.of(context).orientation;

    // Set reference dimensions
    mobileReferenceHeight = mobileSize.height;
    mobileReferenceWidth = mobileSize.width;
    tabletReferenceHeight = tabletSize.height;
    tabletReferenceWidth = tabletSize.width;

    // Determine if device is tablet (using custom check or default)
    isTablet = customTabletCheck != null
        ? customTabletCheck(size)
        : _defaultTabletCheck(size);

    _initialized = true;

    // Debug logging if enabled
    if (isDebugPrint) {
      _appLogger.success(
        "Screen Dimension: ${screenWidth.toStringAsFixed(1)}x${screenHeight.toStringAsFixed(1)}",
      );
      _appLogger.success("isTablet: $isTablet");
      _appLogger.success(
        "Reference (mobile: ${mobileSize.width}x${mobileSize.height}, tablet: ${tabletSize.width}x${tabletSize.height})",
      );
    }
  }

  /// Default tablet detection logic:
  /// - Shortest side >= 600dp (Material Design tablet breakpoint)
  /// - Aspect ratio < 1.6 (excludes foldables and large phones)
  static bool _defaultTabletCheck(Size size) {
    final shortestSide = size.shortestSide;
    return shortestSide >= 600 && (size.height / size.width) < 1.6;
  }

  /// Scales height proportionally based on reference device height
  ///
  /// @param inputHeight The height value from reference design
  /// @return The scaled height for current device
  static double height(double inputHeight) {
    _assertInitialized();
    final refHeight = isTablet ? tabletReferenceHeight : mobileReferenceHeight;
    return (inputHeight / refHeight) * screenHeight;
  }

  /// Scales width proportionally based on reference device width
  ///
  /// @param inputWidth The width value from reference design
  /// @return The scaled width for current device
  static double width(double inputWidth) {
    _assertInitialized();
    final refWidth = isTablet ? tabletReferenceWidth : mobileReferenceWidth;
    return (inputWidth / refWidth) * screenWidth;
  }

  /// Scales font size proportionally based on reference device width
  /// (Uses width scaling as it typically provides better text scaling)
  ///
  /// @param fontSize The font size from reference design
  /// @return The scaled font size for current device
  static double scale(double fontSize) {
    _assertInitialized();
    final refWidth = isTablet ? tabletReferenceWidth : mobileReferenceWidth;
    return (fontSize / refWidth) * screenWidth;
  }

  /// Ensures the ResponsiveConfig has been initialized before use
  static void _assertInitialized() {
    if (!_initialized) {
      throw FlutterError(
        'ResponsiveConfig not initialized. Call ResponsiveConfig.init() before using any scaling methods.',
      );
    }
  }
}
