import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:ali_therapy_admin/core/routes/auth_session_listenable.dart';
import 'package:ali_therapy_admin/core/utils/app_debug_logger.dart';
import 'package:ali_therapy_admin/feature/auth/data/login_data/models/login_model.dart';

// ============================================================
// AUTH LOCAL STORAGE
// ------------------------------------------------------------
// Saves login data on the phone (SharedPreferences).
//
// Why?
//   - App band hone ke baad bhi token yaad rahe
//   - Har API call pe Bearer token bhej sakein
//
// Beginner tip:
//   SharedPreferences = simple key/value storage on device.
// ============================================================

class AuthLocalStorage {
  AuthLocalStorage(this._prefs);

  final SharedPreferences _prefs;

  static const String _tokenKey = 'auth_access_token';
  static const String _loginJsonKey = 'auth_login_json';
  // Kept after logout so the login email field can be prefilled.
  static const String _lastEmailKey = 'auth_last_login_email';

  /// Save full login result after successful API login.
  Future<void> saveLogin(LoginModel login) async {
    await _prefs.setString(_tokenKey, login.accessToken);
    await _prefs.setString(_loginJsonKey, jsonEncode(login.toJson()));
    AppDebugLogger.local(
      action: 'SAVE',
      key: _tokenKey,
      value: AppDebugLogger.maskSecret(login.accessToken),
    );
    AppDebugLogger.local(
      action: 'SAVE',
      key: _loginJsonKey,
      value: _loginSummary(login),
    );
    // Do not notify GoRouter here. LoginPage still has AuthBloc running;
    // a redirect now would dispose the page before AuthAuthenticated emits.
    // Navigation happens from the AuthAuthenticated listener (goHome).
  }

  /// Token used by Dio interceptor as: Authorization Bearer token.
  Future<String?> getToken() async {
    return getTokenSync();
  }

  /// Sync token read — for Image.network headers (prefs already loaded).
  String? getTokenSync() {
    final token = _prefs.getString(_tokenKey);
    if (token == null || token.trim().isEmpty || token == '_') {
      return null;
    }
    return token;
  }

  /// Restore last login (user + permissions + roles) if saved.
  Future<LoginModel?> getSavedLogin() async {
    return getSavedLoginSync();
  }

  /// Sync login read — used for permission checks (prefs already loaded).
  LoginModel? getSavedLoginSync() {
    if (!hasSessionSync()) return null;

    final raw = _prefs.getString(_loginJsonKey);
    if (raw == null || raw.isEmpty) return null;

    try {
      final map = jsonDecode(raw);
      if (map is! Map) return null;
      return LoginModel.fromJson(Map<String, dynamic>.from(map));
    } catch (_) {
      // Corrupt JSON — treat as logged out.
      return null;
    }
  }

  /// Remember the email used to log in (survives logout).
  Future<void> saveLastEmail(String email) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty || trimmed == '_') return;

    await _prefs.setString(_lastEmailKey, trimmed);
    AppDebugLogger.local(
      action: 'SAVE',
      key: _lastEmailKey,
      value: trimmed,
    );
  }

  /// Last login email, or empty when none is saved.
  String lastEmailSync() {
    final email = _prefs.getString(_lastEmailKey);
    if (email == null || email.trim().isEmpty || email == '_') {
      return '';
    }
    return email.trim();
  }

  /// True when a usable token exists (async).
  Future<bool> hasSession() async {
    return hasSessionSync();
  }

  /// Sync check — used by GoRouter redirect (no await needed).
  bool hasSessionSync() {
    final token = _prefs.getString(_tokenKey);
    return token != null && token.trim().isNotEmpty && token != '_';
  }

  /// Clear the session on logout. Last email is kept for the login field.
  Future<void> clear() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_loginJsonKey);
    AppDebugLogger.local(
      action: 'CLEAR',
      key: '$_tokenKey + $_loginJsonKey',
      value: 'session removed (last email kept)',
    );
    AuthSessionListenable.instance.notify();
  }

  /// Print every stored key (app start). Token is masked.
  void logAllStored({String reason = 'snapshot'}) {
    final keys = _prefs.getKeys().toList()..sort();
    if (keys.isEmpty) {
      AppDebugLogger.local(
        action: 'READ',
        key: 'SharedPreferences',
        value: '(empty) — $reason',
      );
      return;
    }

    AppDebugLogger.local(
      action: 'READ',
      key: 'SharedPreferences ($reason)',
      value: '${keys.length} key(s): ${keys.join(', ')}',
    );

    for (final key in keys) {
      AppDebugLogger.local(
        action: 'READ',
        key: key,
        value: _valueForLog(key, _prefs.get(key)),
      );
    }
  }

  String _loginSummary(LoginModel login) {
    final roles = login.roles.map((item) => item.name).join(', ');
    return 'user=${login.user.name}  email=${login.user.email}  '
        'roles=$roles  permissions=${login.permissions.length}  '
        'token=${AppDebugLogger.maskSecret(login.accessToken)}';
  }

  String _valueForLog(String key, Object? value) {
    if (value == null) return '(null)';
    if (key.contains('token') || key.contains('Token')) {
      return AppDebugLogger.maskSecret(value.toString());
    }
    if (key == _loginJsonKey) {
      final saved = getSavedLoginSync();
      if (saved != null) return _loginSummary(saved);
    }
    return AppDebugLogger.clip(value.toString());
  }
}
