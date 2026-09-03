// ============================================================
// PATIENT DETAIL JSON HELPERS
// ------------------------------------------------------------
// Null / empty / "N/A" → "_" so every field label still shows.
// ============================================================

class PatientDetailJsonHelpers {
  PatientDetailJsonHelpers._();

  static const String empty = '_';

  static String text(dynamic value) {
    if (value == null) return empty;
    if (value is List) {
      final parts = stringList(value);
      return parts.isEmpty ? empty : parts.join(', ');
    }
    if (value is Map) {
      final map = mapOrNull(value);
      if (map == null) return empty;
      return textOf(map, const ['name', 'title', 'label', 'value']);
    }
    final text = value.toString().trim();
    if (text.isEmpty || text == '—') return empty;
    if (text.toLowerCase() == 'n/a') return empty;
    return text;
  }

  static String textOf(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      if (!json.containsKey(key)) continue;
      final value = text(json[key]);
      if (value.isNotEmpty && value != empty) return value;
    }
    return empty;
  }

  static int integer(dynamic value, {int fallback = 0}) {
    if (value == null) return fallback;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString().trim()) ?? fallback;
  }

  static bool flag(dynamic value, {bool fallback = true}) {
    if (value == null) return fallback;
    if (value is bool) return value;
    if (value is num) return value != 0;
    final text = value.toString().trim().toLowerCase();
    if (text == 'true' || text == '1' || text == 'yes') return true;
    if (text == 'false' || text == '0' || text == 'no') return false;
    return fallback;
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
      final text = PatientDetailJsonHelpers.text(item);
      if (text.isNotEmpty && text != empty) result.add(text);
    }
    return result;
  }

  /// First JSON object from a map or a list of maps.
  static Map<String, dynamic>? firstMap(dynamic value) {
    final asMap = mapOrNull(value);
    if (asMap != null) return asMap;
    for (final item in listOrEmpty(value)) {
      final nested = mapOrNull(item);
      if (nested != null) return nested;
    }
    return null;
  }

  /// `{ "Cervical": "positive" }`, `[{ "name": "Knee", "value": "..." }]`,
  /// or a list of strings.
  static Map<String, String> stringMap(dynamic value) {
    final result = <String, String>{};
    final asMap = mapOrNull(value);
    if (asMap != null) {
      asMap.forEach((key, raw) {
        result[key] = text(raw);
      });
      return result;
    }
    for (final item in listOrEmpty(value)) {
      final map = mapOrNull(item);
      if (map != null) {
        final key = textOf(map, const [
          'name',
          'title',
          'label',
          'region',
          'key',
        ]);
        if (key.isEmpty) continue;
        result[key] = textOf(map, const [
          'value',
          'result',
          'finding',
          'text',
        ]);
        continue;
      }
      final label = text(item);
      if (label.isNotEmpty) result[label] = '';
    }
    return result;
  }

  static List<T> mapList<T>(
    dynamic raw,
    T Function(Map<String, dynamic> json) fromJson,
  ) {
    final result = <T>[];
    for (final item in listOrEmpty(raw)) {
      final map = mapOrNull(item);
      if (map == null) continue;
      result.add(fromJson(map));
    }
    return result;
  }
}
