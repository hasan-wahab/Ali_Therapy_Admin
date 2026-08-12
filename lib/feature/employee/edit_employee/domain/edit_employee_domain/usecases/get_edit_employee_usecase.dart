import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/edit_employee_entity.dart';
import '../repositories/edit_employee_repository.dart';

// ============================================================
// GET EDITEMPLOYEE USE CASE
// ------------------------------------------------------------
// One job: fetch edit employee data.
// ============================================================

class GetEditEmployeeUseCase extends UseCase<EditEmployeeEntity, NoParams> {
  final EditEmployeeRepository repository;

  GetEditEmployeeUseCase(this.repository);

  @override
  ResultFuture<EditEmployeeEntity> call(NoParams params) {
    return repository.getEditEmployee();
  }
}
