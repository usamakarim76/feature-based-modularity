import 'dart:developer';
import 'package:flutter/foundation.dart';

/// A utility class for standardized application logging with screen-level context.
/// Logs are only printed in debug mode and include the screen name for better traceability.
class AppLogger {
  /// The name of the screen/widget where the logger is being used
  final String _className;

  /// Creates a logger instance with screen name context
  ///
  /// Prefer using [AppLogger.forScreen] named constructor for better readability
  /// Example:
  /// ```dart
  /// final logger = AppLogger.forScreen('HomeScreen');
  /// ```
  AppLogger({required String className}) : _className = className;

  /// Named constructor for better code readability when creating logger instances
  factory AppLogger.forScreen(String screenName) =>
      AppLogger(className: screenName);

  /// Internal method that handles the actual logging with consistent formatting
  ///
  /// @param label The log level/type (ERROR, INFO, etc.)
  /// @param message The message to be logged
  void _log(String label, String message) {
    if (kDebugMode) {
      final text = '[$_className] $message';
      log(text, name: label);
    }
  }

  /// Logs an error message (highest priority)
  void error(String message) => _log('ERROR', message);

  /// Logs an informational message
  void info(String message) => _log('INFO', message);

  /// Logs a success message (for positive outcomes)
  void success(String message) => _log('SUCCESS', message);

  /// Logs a warning message (potential issues)
  void warning(String message) => _log('WARNING', message);

  /// Logs a debug message (for development debugging)
  void debug(String message) => _log('DEBUG', message);

  /// Specialized logger for JSON data with pretty formatting
  ///
  /// @param label The context for this JSON log
  /// @param jsonString The JSON string to log (will be printed with newlines)
  void logJson(String label, String jsonString) {
    if (kDebugMode) {
      final header = '[$_className] JSON:';
      log('$header\n$jsonString', name: label);
    }
  }

  /// Specialized logger for HTTP requests
  ///
  /// @param method The HTTP method (GET, POST, etc.)
  /// @param url The request URL
  /// @param [statusCode] Optional status code for responses
  /// @param [body] Optional request/response body
  void logHttp({
    required String method,
    required String url,
    int? statusCode,
    String? body,
  }) {
    if (kDebugMode) {
      final message = StringBuffer()
        ..write('$method $url')
        ..write(statusCode != null ? ' → $statusCode' : '')
        ..write(body != null ? '\nBody: $body' : '');
      _log('HTTP', message.toString());
    }
  }
}
