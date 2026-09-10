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

  /// "islamabad" → "Islamabad", "wah_cantt" → "Wah Cantt".
  /// Emails stay exactly as typed / returned by the API.
  static String titleCase(String raw) {
    final text = raw.trim();
    if (text.isEmpty) return '';
    if (_looksLikeEmail(text)) return text;
    final words = text
        .replaceAll('_', ' ')
        .replaceAll('-', ' ')
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty);
    return words.map(_titleWord).join(' ');
  }

  /// First letter of the sentence; rest stays as typed.
  /// Emails stay exactly as typed / returned by the API.
  static String sentenceCase(String raw) {
    final text = raw.trim();
    if (text.isEmpty) return '';
    if (_looksLikeEmail(text)) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static bool _looksLikeEmail(String value) => value.contains('@');

  static String _titleWord(String word) {
    if (word.isEmpty) return word;
    if (word.length == 1) return word.toUpperCase();
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
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
