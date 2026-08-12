import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/profile_entity.dart';

// ============================================================
// PROFILE REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class ProfileRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<ProfileEntity> getProfile();
}
