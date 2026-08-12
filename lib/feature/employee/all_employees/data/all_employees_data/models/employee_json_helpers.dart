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
