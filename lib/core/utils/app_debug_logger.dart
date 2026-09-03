import 'package:flutter/foundation.dart';

// ============================================================
// APP DEBUG LOGGER
// ------------------------------------------------------------
// Debug-console logs for things PrettyDioLogger does NOT print:
//   - local storage (save / read / clear)
//   - app actions (bloc event → state, navigation, picker)
//
// Release builds print nothing.
// ============================================================

class AppDebugLogger {
  AppDebugLogger._();

  /// Phone storage (SharedPreferences).
  static void local({
    required String action,
    required String key,
    String? value,
  }) {
    _printBlock(
      kind: 'LOCAL STORE',
      source: action,
      title: key,
      message: value ?? '',
    );
  }

  /// Something the app did (event, new state, route, picker).
  static void action({
    required String where,
    required String action,
    String? detail,
  }) {
    _printBlock(
      kind: 'ACTION',
      source: where,
      title: action,
      message: detail ?? '',
    );
  }

  /// Hide most of a secret (token) so logs stay readable.
  static String maskSecret(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '(empty)';
    final value = raw.trim();
    if (value.length <= 10) return '**** (${value.length} chars)';
    return '${value.substring(0, 6)}…${value.substring(value.length - 4)} '
        '(${value.length} chars)';
  }

  /// Keep long JSON from flooding the console.
  static String clip(String raw, {int max = 500}) {
    final text = raw.trim();
    if (text.length <= max) return text;
    return '${text.substring(0, max)}… (${text.length} chars)';
  }

  static void _printBlock({
    required String kind,
    required String source,
    required String title,
    required String message,
  }) {
    if (!kDebugMode) return;

    debugPrint('');
    debugPrint('╔══════════════════════════════════════════════');
    debugPrint('║ $kind ($source)');
    debugPrint('╠══════════════════════════════════════════════');
    debugPrint('║ TITLE   : $title');
    if (message.trim().isNotEmpty) {
      for (final line in message.split('\n')) {
        debugPrint('║ VALUE   : $line');
      }
    }
    debugPrint('╚══════════════════════════════════════════════');
    debugPrint('');
  }
}
