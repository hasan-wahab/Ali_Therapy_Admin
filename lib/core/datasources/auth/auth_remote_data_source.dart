import '../../../feature/auth/data/change_password_data/models/change_password_model.dart';
import '../../../feature/auth/data/forget_password_data/models/forget_password_model.dart';
import '../../../feature/auth/data/login_data/models/login_model.dart';

// ============================================================
// AUTH REMOTE DATA SOURCE (contract)
// ------------------------------------------------------------
// Lives in core/datasources/auth/
// Talks to the API. Throws AppException on errors.
// ============================================================

abstract class AuthRemoteDataSource {
  /// POST login → returns parsed LoginModel (token + user + permissions).
  Future<LoginModel> login({
    required String email,
    required String password,
  });

  /// POST logout on the server (token should already be attached by Dio).
  Future<void> logout();

  /// POST forgot-password → sends reset email for this address.
  Future<ForgetPasswordModel> forgetPassword({required String email});

  /// POST change-password.
  /// Body: { current_password, new_password }
  /// Header: Authorization Bearer (via Dio interceptor).
  Future<ChangePasswordModel> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
