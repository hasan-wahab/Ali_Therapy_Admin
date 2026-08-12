import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/all_patients_entity.dart';
import '../repositories/all_patients_repository.dart';

// ============================================================
// GET ALLPATIENTS USE CASE
// ------------------------------------------------------------
// One job: fetch all patients data.
// ============================================================

class GetAllPatientsUseCase extends UseCase<AllPatientsEntity, NoParams> {
  final AllPatientsRepository repository;

  GetAllPatientsUseCase(this.repository);

  @override
  ResultFuture<AllPatientsEntity> call(NoParams params) {
    return repository.getAllPatients();
  }
}
