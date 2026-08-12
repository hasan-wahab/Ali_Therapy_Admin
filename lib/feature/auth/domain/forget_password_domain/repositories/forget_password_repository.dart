import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/forget_password_entity.dart';

// ============================================================
// FORGET PASSWORD REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class ForgetPasswordRepository {
  /// Ask the server to send a password-reset email / OTP.
  ResultFuture<ForgetPasswordEntity> requestReset({required String email});
}
