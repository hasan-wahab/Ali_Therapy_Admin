import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/consultant_details_entity.dart';

// ============================================================
// CONSULTANTDETAILS REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class ConsultantDetailsRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<ConsultantDetailsEntity> getConsultantDetails();
}
