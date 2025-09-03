import 'dart:async';
import 'package:flutter/foundation.dart';

/// A utility class that debounces (delays) the execution of a function
/// until a specified time has elapsed without the function being called again.
/// This is particularly useful for handling rapid successive events like
/// search-as-you-type or button spamming.
class Debouncer {
  /// The duration to wait before executing the action, in milliseconds
  final int milliseconds;

  /// The timer that manages the delay period
  Timer? _timer;

  /// Creates a new Debouncer with an optional delay duration
  ///
  /// @param milliseconds The delay duration in milliseconds before executing
  /// the action after the last call to [run]. Defaults to 300ms.
  Debouncer({this.milliseconds = 500});

  /// Runs the given action after the debounce period, cancelling any
  /// previously scheduled executions.
  ///
  /// @param action The callback function to execute after the debounce period
  void run(VoidCallback action) {
    // Cancel any previously scheduled timer to ensure we only execute
    // the action after the full debounce period of inactivity
    _timer?.cancel();

    // Schedule a new timer with the specified delay
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  /// Cancels any pending debounced action and cleans up resources.
  /// This should be called when the Debouncer is no longer needed
  /// to prevent memory leaks.
  void dispose() {
    _timer?.cancel();
  }
}
