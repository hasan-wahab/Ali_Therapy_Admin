import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:ali_therapy_admin/core/routes/auth_session_listenable.dart';
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

  /// Save full login result after successful API login.
  Future<void> saveLogin(LoginModel login) async {
    await _prefs.setString(_tokenKey, login.accessToken);
    await _prefs.setString(_loginJsonKey, jsonEncode(login.toJson()));
    AuthSessionListenable.instance.notify();
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
    final token = await getToken();
    if (token == null) return null;

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

  /// True when a usable token exists (async).
  Future<bool> hasSession() async {
    return hasSessionSync();
  }

  /// Sync check — used by GoRouter redirect (no await needed).
  bool hasSessionSync() {
    final token = _prefs.getString(_tokenKey);
    return token != null && token.trim().isNotEmpty && token != '_';
  }

  /// Clear everything on logout.
  Future<void> clear() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_loginJsonKey);
    AuthSessionListenable.instance.notify();
  }
}
