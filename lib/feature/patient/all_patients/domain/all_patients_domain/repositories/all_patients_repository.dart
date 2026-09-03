import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../entities/patients_list_query.dart';
import '../entities/patients_page_entity.dart';

// ============================================================
// ALL PATIENTS REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class AllPatientsRepository {
  /// Load one page of patients (search + filters + page).
  ResultFuture<PatientsPageEntity> getPatientsPage({
    required PatientsListQuery query,
  });
}
