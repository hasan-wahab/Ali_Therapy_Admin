import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../entities/change_password_entity.dart';

// ============================================================
// CHANGE PASSWORD REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------

abstract class ChangePasswordRepository {
  ResultFuture<ChangePasswordEntity> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
