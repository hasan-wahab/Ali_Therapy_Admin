import 'package:intl/intl.dart';

/// ============================================================
/// HELPERS
/// ------------------------------------------------------------
/// Small reusable functions used in many screens.
/// Keep this file free of business logic — only helpers.
/// ============================================================

class Helpers {
  Helpers._();

  // ----------------------------------------------------------
  // DATE / TIME
  // ----------------------------------------------------------

  /// Format a DateTime for the UI.
  /// Example: 06 Aug 2026
  static String formatDate(DateTime date, {String pattern = 'dd MMM yyyy'}) {
    return DateFormat(pattern).format(date);
  }

  /// Today's date as yyyy-MM-dd (API / filter draft).
  static String todayApiDate() =>
      formatDate(DateTime.now(), pattern: 'yyyy-MM-dd');

  /// Today's date as MM/dd/yyyy (filter display).
  static String todayDisplayDate() =>
      formatDate(DateTime.now(), pattern: 'MM/dd/yyyy');

  /// Format date + time.
  /// Example: 06 Aug 2026, 03:30 PM
  static String formatDateTime(
    DateTime date, {
    String pattern = 'dd MMM yyyy, hh:mm a',
  }) {
    return DateFormat(pattern).format(date);
  }

  /// Parse an API date string safely.
  /// Returns null if the string is invalid.
  static DateTime? tryParseDate(String? value) {
    if (value == null || value.isEmpty) return null;
    return DateTime.tryParse(value);
  }

  // ----------------------------------------------------------
  // STRINGS
  // ----------------------------------------------------------

  /// Capitalize the first letter.
  /// Example: "admin" → "Admin"
  static String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  /// Show a short version of long text.
  /// Example: "Hello world..." if longer than [max]
  static String truncate(String value, {int max = 40}) {
    if (value.length <= max) return value;
    return '${value.substring(0, max)}...';
  }

  // ----------------------------------------------------------
  // NUMBERS
  // ----------------------------------------------------------

  /// Format money-like numbers.
  /// Example: 1500 → "1,500"
  static String formatNumber(num value) {
    return NumberFormat('#,##0').format(value);
  }
}
