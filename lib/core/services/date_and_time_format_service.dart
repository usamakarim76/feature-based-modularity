// lib/services/date_time_formatter_service.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormatterService {
  /// Format Date to: `dd-MM-yyyy`, `MMM d, yyyy`, etc.
  static String formatDate(DateTime date, {String pattern = 'dd-MM-yyyy'}) {
    return DateFormat(pattern).format(date);
  }

  /// Format TimeOfDay to: `HH:mm`, `h:mm a`, etc.
  static String formatTimeOfDay(
    TimeOfDay time, {
    String pattern = 'h:mm a',
    bool is24HourFormat = false,
  }) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat(is24HourFormat ? 'h:mm' : pattern).format(dt);
  }

  /// Combine Date and Time: `MMM d, yyyy - h:mm a`
  static String formatDateTime(
    DateTime dateTime, {
    String pattern = 'MMM d, yyyy - h:mm a',
  }) {
    return DateFormat(pattern).format(dateTime);
  }

  /// Convert TimeOfDay to DateTime
  static DateTime timeOfDayToDateTime(TimeOfDay timeOfDay, [DateTime? date]) {
    final baseDate = date ?? DateTime.now();
    return DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }
}
