import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/employee_entity.dart';
import '../repositories/all_employees_repository.dart';

// ============================================================
// GET ALLEMPLOYEES USE CASE
// ------------------------------------------------------------
// One job: fetch all employees list.
// ============================================================

class GetAllEmployeesUseCase
    extends UseCase<List<EmployeeEntity>, NoParams> {
  final AllEmployeesRepository repository;

  GetAllEmployeesUseCase(this.repository);

  @override
  ResultFuture<List<EmployeeEntity>> call(NoParams params) {
    return repository.getAllEmployees();
  }
}
