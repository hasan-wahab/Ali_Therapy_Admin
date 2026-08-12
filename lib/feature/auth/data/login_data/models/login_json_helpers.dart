/// Shared JSON helpers for login models.
///
/// Rule: any null / empty API value becomes "_" for UI display.
/// Exception: access_token must stay a real token (see [requiredToken]).
class LoginJsonHelpers {
  LoginJsonHelpers._();

  /// Convert any JSON value → display String ("_" if null/empty).
  static String text(dynamic value) {
    if (value == null) return '_';
    final text = value.toString().trim();
    return text.isEmpty ? '_' : text;
  }

  /// Required token string — throws if missing (do NOT use "_").
  static String requiredToken(dynamic value) {
    if (value == null) {
      throw const FormatException('access_token is missing');
    }
    final token = value.toString().trim();
    if (token.isEmpty) {
      throw const FormatException('access_token is empty');
    }
    return token;
  }

  /// Safe Map cast (or null).
  static Map<String, dynamic>? mapOrNull(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return null;
  }
}
