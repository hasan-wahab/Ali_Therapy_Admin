import 'package:flutter/foundation.dart';

// ============================================================
// AUTH SESSION LISTENABLE
// ------------------------------------------------------------
// Tells GoRouter: "session changed — run redirect again".
//
// Call [notify] after login save or logout clear.
// ============================================================

class AuthSessionListenable extends ChangeNotifier {
  AuthSessionListenable._();

  static final AuthSessionListenable instance = AuthSessionListenable._();

  /// Call this after token is saved or cleared.
  void notify() => notifyListeners();
}
