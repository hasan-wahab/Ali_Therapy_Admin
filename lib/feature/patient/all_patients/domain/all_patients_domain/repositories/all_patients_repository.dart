import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/all_patients_entity.dart';

// ============================================================
// ALLPATIENTS REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class AllPatientsRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<AllPatientsEntity> getAllPatients();
}
