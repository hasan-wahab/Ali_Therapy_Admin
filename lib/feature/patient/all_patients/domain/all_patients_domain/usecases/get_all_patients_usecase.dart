import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../entities/patients_list_query.dart';
import '../entities/patients_page_entity.dart';
import '../repositories/all_patients_repository.dart';

// ============================================================
// GET ALL PATIENTS USE CASE
// ------------------------------------------------------------
// One job: load one patients page (with search + filters).
// ============================================================

class GetAllPatientsUseCase
    extends UseCase<PatientsPageEntity, PatientsListQuery> {
  GetAllPatientsUseCase(this.repository);

  final AllPatientsRepository repository;

  @override
  ResultFuture<PatientsPageEntity> call(PatientsListQuery params) {
    return repository.getPatientsPage(query: params);
  }
}
