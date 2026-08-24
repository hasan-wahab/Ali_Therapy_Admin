/// Shared JSON helpers for the edit-employee models.
class EditEmployeeJsonHelpers {
  EditEmployeeJsonHelpers._();

  /// Form field: null / empty / "_" → "".
  static String field(dynamic value) {
    if (value == null) return '';
    if (value is List) {
      final names = <String>[];
      for (final item in value) {
        final text = field(item);
        if (text.isNotEmpty) names.add(text);
      }
      return names.join(', ');
    }
    if (value is Map) {
      final map = mapOrNull(value);
      if (map == null) return '';
      return fieldOf(map, const ['name', 'title', 'label']);
    }
    final text = value.toString().trim();
    if (text.isEmpty || text == '_') return '';
    return text;
  }

  static String fieldOf(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      if (!json.containsKey(key)) continue;
      final text = field(json[key]);
      if (text.isNotEmpty) return text;
    }
    return '';
  }

  static String idOf(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      if (!json.containsKey(key)) continue;
      final raw = json[key];
      if (raw == null) continue;
      if (raw is Map) {
        final nested = mapOrNull(raw);
        if (nested == null) continue;
        final nestedId = idOf(nested, const ['id', 'value']);
        if (nestedId.isNotEmpty) return nestedId;
        continue;
      }
      final text = raw.toString().trim();
      if (text.isNotEmpty && text != '_') return text;
    }
    return '';
  }

  /// Scalar `*_id` first, then nested `{ id, name }` (same as View JSON).
  static String relationId(
    Map<String, dynamic> json, {
    required List<String> idKeys,
    String? objectKey,
  }) {
    final fromId = idOf(json, idKeys);
    if (fromId.isNotEmpty) return fromId;
    if (objectKey == null) return '';
    final nested = mapOrNull(json[objectKey]);
    if (nested == null) return '';
    return idOf(nested, const ['id', 'value']);
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

  /// Display date as MM/dd/yyyy when we can parse it.
  static String displayDate(String raw) {
    final text = raw.trim();
    if (text.isEmpty) return '';
    final iso = DateTime.tryParse(text);
    if (iso != null) {
      final m = iso.month.toString().padLeft(2, '0');
      final d = iso.day.toString().padLeft(2, '0');
      return '$m/$d/${iso.year}';
    }
    final slash = RegExp(r'^(\d{1,2})[/-](\d{1,2})[/-](\d{4})$');
    final match = slash.firstMatch(text);
    if (match != null) {
      final a = int.tryParse(match.group(1)!) ?? 0;
      final b = int.tryParse(match.group(2)!) ?? 0;
      final y = match.group(3)!;
      // Treat first part > 12 as day-first (dd/MM/yyyy).
      if (a > 12 && b <= 12) {
        return '${b.toString().padLeft(2, '0')}/${a.toString().padLeft(2, '0')}/$y';
      }
      return '${a.toString().padLeft(2, '0')}/${b.toString().padLeft(2, '0')}/$y';
    }
    return text;
  }

  /// API date as yyyy-MM-dd when we can parse it.
  static String apiDate(String raw) {
    final text = raw.trim();
    if (text.isEmpty) return '';
    final iso = DateTime.tryParse(text);
    if (iso != null) {
      final m = iso.month.toString().padLeft(2, '0');
      final d = iso.day.toString().padLeft(2, '0');
      return '${iso.year}-$m-$d';
    }
    final slash = RegExp(r'^(\d{1,2})[/-](\d{1,2})[/-](\d{4})$');
    final match = slash.firstMatch(text);
    if (match != null) {
      final a = int.tryParse(match.group(1)!) ?? 0;
      final b = int.tryParse(match.group(2)!) ?? 0;
      final y = match.group(3)!;
      if (a > 12 && b <= 12) {
        return '$y-${b.toString().padLeft(2, '0')}-${a.toString().padLeft(2, '0')}';
      }
      return '$y-${a.toString().padLeft(2, '0')}-${b.toString().padLeft(2, '0')}';
    }
    return text;
  }

  static Object? idValue(String id) {
    final text = id.trim();
    if (text.isEmpty) return null;
    return int.tryParse(text) ?? text;
  }

  /// UI label for API gender (`male` / `female`).
  static String genderDisplay(String raw) {
    final value = raw.trim().toLowerCase();
    if (value == 'male') return 'Male';
    if (value == 'female') return 'Female';
    return raw.trim();
  }

  /// API gender. Null if not male/female.
  static String? genderApi(String raw) {
    final value = raw.trim().toLowerCase();
    if (value == 'male' || value == 'female') return value;
    return null;
  }

  /// UI label for API salary_type (`fixed` / `commission`).
  static String salaryTypeDisplay(String raw) {
    final value = raw.trim().toLowerCase();
    if (value == 'fixed') return 'Fixed';
    if (value == 'commission') return 'Commission';
    return raw.trim();
  }

  /// API salary_type. Null if not fixed/commission.
  static String? salaryTypeApi(String raw) {
    final value = raw.trim().toLowerCase();
    if (value == 'fixed' || value == 'commission') return value;
    return null;
  }

  /// Salary amount as a number (docs: numeric).
  static num? salaryNumber(String raw) {
    final cleaned = raw.trim().replaceAll(',', '');
    if (cleaned.isEmpty) return null;
    return num.tryParse(cleaned);
  }
}
