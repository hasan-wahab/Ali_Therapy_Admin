import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/profile_entity.dart';

// ============================================================
// PROFILE REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class ProfileRepository {
  /// Load full employee profile by id.
  ResultFuture<ProfileEntity> getProfile({required String employeeId});
}
