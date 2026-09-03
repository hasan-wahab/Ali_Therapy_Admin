// ============================================================
// PATIENT JSON HELPERS
// ------------------------------------------------------------
// Null / empty / "N/A" → "_" so the UI still shows the field.
// ============================================================

class PatientJsonHelpers {
  PatientJsonHelpers._();

  static const String empty = '_';

  static String text(dynamic value) {
    if (value == null) return empty;
    if (value is List) {
      final parts = stringList(value);
      return parts.isEmpty ? empty : parts.join(', ');
    }
    final text = value.toString().trim();
    if (text.isEmpty || text == '—') return empty;
    if (text.toLowerCase() == 'n/a') return empty;
    return text;
  }

  static int integer(dynamic value, {int fallback = 0}) {
    if (value == null) return fallback;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString().trim()) ?? fallback;
  }

  static double decimal(dynamic value, {double fallback = 0}) {
    if (value == null) return fallback;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString().trim().replaceAll(',', '')) ??
        fallback;
  }

  static Map<String, dynamic>? mapOrNull(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return null;
  }

  static List<dynamic> listOrEmpty(dynamic value) {
    if (value is List) return value;
    return const [];
  }

  static List<String> stringList(dynamic value) {
    final result = <String>[];
    for (final item in listOrEmpty(value)) {
      if (item == null) continue;
      final text = item.toString().trim();
      if (text.isEmpty || text == empty || text == '—') continue;
      if (text.toLowerCase() == 'n/a') continue;
      result.add(text);
    }
    return result;
  }
}
