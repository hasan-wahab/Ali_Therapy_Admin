import 'package:ali_therapy_admin/core/utils/helpers.dart';

/// Shared JSON helpers for patient registration form-data.
class PatientFormJsonHelpers {
  PatientFormJsonHelpers._();

  static String text(dynamic value) {
    if (value == null) return '';
    final text = value.toString().trim();
    if (text.isEmpty || text == '_') return '';
    if (text.toLowerCase() == 'n/a') return '';
    return text;
  }

  static bool flag(dynamic value) {
    if (value == true || value == 1) return true;
    if (value is String) {
      final text = value.trim().toLowerCase();
      return text == 'true' || text == '1' || text == 'yes';
    }
    return false;
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

  /// API sends plain strings: ["islamabad", "wah_cantt"] → Title Case.
  static List<String> stringList(dynamic raw) {
    final result = <String>[];
    final seen = <String>{};
    for (final item in listOrEmpty(raw)) {
      final titled = titleCase(PatientFormJsonHelpers.text(item));
      if (titled.isEmpty) continue;
      final key = compact(titled);
      if (seen.contains(key)) continue;
      seen.add(key);
      result.add(titled);
    }
    return result;
  }

  /// "islamabad" → "Islamabad", "wah_cantt" → "Wah Cantt", "a+" → "A+".
  static String titleCase(String raw) => Helpers.titleCase(raw);

  /// Form shows MM/dd/yyyy. Create API wants yyyy-MM-dd.
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
    if (match == null) return text;
    final a = int.tryParse(match.group(1)!) ?? 0;
    final b = int.tryParse(match.group(2)!) ?? 0;
    final y = match.group(3)!;
    if (a > 12 && b <= 12) {
      return '$y-${b.toString().padLeft(2, '0')}-${a.toString().padLeft(2, '0')}';
    }
    return '$y-${a.toString().padLeft(2, '0')}-${b.toString().padLeft(2, '0')}';
  }

  static int? ageNumber(String raw) {
    final text = raw.trim();
    if (text.isEmpty) return null;
    return int.tryParse(text);
  }

  /// Nested map / list / scalar → a single display string.
  static String field(dynamic value) {
    if (value == null) return '';
    if (value is List) {
      for (final item in value) {
        final text = field(item);
        if (text.isNotEmpty) return text;
      }
      return '';
    }
    if (value is Map) {
      final map = mapOrNull(value);
      if (map == null) return '';
      return fieldOf(map, const ['name', 'title', 'label', 'value']);
    }
    return text(value);
  }

  static String fieldOf(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      if (!json.containsKey(key)) continue;
      final value = field(json[key]);
      if (value.isNotEmpty) return value;
    }
    return '';
  }

  /// Form date field: MM/dd/yyyy.
  static String displayDate(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return '';
    final iso = DateTime.tryParse(value);
    if (iso != null) {
      final m = iso.month.toString().padLeft(2, '0');
      final d = iso.day.toString().padLeft(2, '0');
      return '$m/$d/${iso.year}';
    }
    final slash = RegExp(r'^(\d{1,2})[/-](\d{1,2})[/-](\d{4})$');
    final match = slash.firstMatch(value);
    if (match == null) return value;
    final a = int.tryParse(match.group(1)!) ?? 0;
    final b = int.tryParse(match.group(2)!) ?? 0;
    final y = match.group(3)!;
    if (a > 12 && b <= 12) {
      return '${b.toString().padLeft(2, '0')}/${a.toString().padLeft(2, '0')}/$y';
    }
    return '${a.toString().padLeft(2, '0')}/${b.toString().padLeft(2, '0')}/$y';
  }

  static String compact(String value) {
    return value.trim().toLowerCase().replaceAll(RegExp(r'[\s_\-]+'), '');
  }

  /// Pick the dropdown item that matches the API value.
  static String matchOption(String raw, List<String> options) {
    final value = raw.trim();
    if (value.isEmpty || options.isEmpty) return '';
    for (final option in options) {
      if (option == value) return option;
    }
    final lower = value.toLowerCase();
    for (final option in options) {
      if (option.toLowerCase() == lower) return option;
    }
    final folded = compact(value);
    for (final option in options) {
      if (compact(option) == folded) return option;
    }
    return '';
  }

  static String ageText(dynamic value) {
    if (value == null) return '';
    if (value is num && value == 0) return '';
    final parsed = text(value);
    if (parsed == '0') return '';
    return parsed;
  }

  static String firstLanguage(dynamic raw) {
    if (raw is List) {
      for (final item in raw) {
        final value = field(item);
        if (value.isNotEmpty) return value;
      }
      return '';
    }
    return field(raw);
  }
}
