import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../entities/login_entity.dart';

// ============================================================
// AUTH REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW it is done.
// The real implementation lives in the data layer.
// ============================================================

abstract class AuthRepository {
  /// Login with email + password.
  /// On success: saves token locally and returns LoginEntity.
  ResultFuture<LoginEntity> login({
    required String email,
    required String password,
  });

  /// Logout: call API (best effort) + clear local token.
  ResultVoid logout();

  /// Restore session from local storage (app restart).
  /// Returns null when user must login again.
  ResultFuture<LoginEntity?> restoreSession();
}
