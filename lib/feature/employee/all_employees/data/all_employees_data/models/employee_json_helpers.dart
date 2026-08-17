/// Shared JSON helpers for all-employees models.
///
/// Rule: any null / empty API value becomes "_" for UI display.
class EmployeeJsonHelpers {
  EmployeeJsonHelpers._();

  /// Convert any JSON value → display String ("_" if null/empty).
  static String text(dynamic value) {
    if (value == null) return '_';
    final text = value.toString().trim();
    return text.isEmpty ? '_' : text;
  }

  /// Convert JSON bool / 0-1 / "true" → bool (default false).
  static bool flag(dynamic value, {bool fallback = false}) {
    if (value == null) return fallback;
    if (value is bool) return value;
    if (value is num) return value != 0;
    final text = value.toString().trim().toLowerCase();
    if (text == 'true' || text == '1' || text == 'yes') return true;
    if (text == 'false' || text == '0' || text == 'no') return false;
    return fallback;
  }

  /// Convert JSON list → List&lt;String&gt; (skips empty items).
  static List<String> stringList(dynamic value) {
    if (value is! List) return const [];
    final result = <String>[];
    for (final item in value) {
      final text = item?.toString().trim() ?? '';
      if (text.isNotEmpty) result.add(text);
    }
    return result;
  }

  /// Safe Map cast (or null).
  static Map<String, dynamic>? mapOrNull(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return null;
  }

  /// Safe List cast (or empty list).
  static List<dynamic> listOrEmpty(dynamic value) {
    if (value is List) return value;
    return const [];
  }
}
