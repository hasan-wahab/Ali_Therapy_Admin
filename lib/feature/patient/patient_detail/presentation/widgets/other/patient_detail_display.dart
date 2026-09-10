import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/utils/helpers.dart';

// ============================================================
// PATIENT DETAIL DISPLAY
// ------------------------------------------------------------
// Empty / N/A values → "_" so labels stay visible.
// ============================================================

class PatientDetailDisplay {
  PatientDetailDisplay._();

  static const String empty = '_';

  static final NumberFormat _money = NumberFormat('#,##0.00', 'en_US');

  static String text(String value) {
    final text = value.trim();
    if (text.isEmpty || text == '—') return empty;
    if (text.toLowerCase() == 'n/a') return empty;
    return text;
  }

  /// Names / labels. Emails stay as returned by the API.
  static String titled(String value) {
    final shown = text(value);
    if (shown == empty) return empty;
    return Helpers.titleCase(shown);
  }

  static String hashedId(String id) {
    final value = text(id);
    if (value == empty) return empty;
    return value.startsWith('#') ? value : '#$value';
  }

  static String ageYears(int age) {
    if (age <= 0) return empty;
    return '$age years';
  }

  static String moneyRs(double value) => 'Rs. ${_money.format(value)}';

  /// Invoice cards currently show plain numbers (e.g. 3000.0).
  static String moneyPlain(double value) => value.toString();

  static String date(String raw) {
    final value = text(raw);
    if (value == empty) return empty;
    final parsed = Helpers.tryParseDate(value);
    if (parsed == null) return value;
    return Helpers.formatDate(parsed, pattern: 'MMM dd, yyyy');
  }

  static String dateTime(String raw) {
    final value = text(raw);
    if (value == empty) return empty;
    final parsed = Helpers.tryParseDate(value);
    if (parsed == null) return value;
    return Helpers.formatDateTime(parsed);
  }

  /// Time-only values such as "14:01:55" → "02:01 PM".
  static String time(String raw) {
    final value = text(raw);
    if (value == empty) return empty;
    final parsed = Helpers.tryParseDate(value) ??
        Helpers.tryParseDate('1970-01-01 $value');
    if (parsed == null) return value;
    return DateFormat('hh:mm a').format(parsed);
  }
}
