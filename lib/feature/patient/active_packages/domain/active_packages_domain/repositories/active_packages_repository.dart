import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/active_packages_entity.dart';

// ============================================================
// ACTIVEPACKAGES REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class ActivePackagesRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<ActivePackagesEntity> getActivePackages();
}
