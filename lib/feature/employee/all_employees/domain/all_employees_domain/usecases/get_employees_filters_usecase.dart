import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../entities/employees_filters_entity.dart';
import '../repositories/all_employees_repository.dart';

// ============================================================
// GET EMPLOYEES FILTERS USE CASE
// ------------------------------------------------------------
// One job: load All Employees filter dropdown data.
// ============================================================

class GetEmployeesFiltersUseCase
    extends UseCase<EmployeesFiltersEntity, NoParams> {
  GetEmployeesFiltersUseCase(this.repository);

  final AllEmployeesRepository repository;

  @override
  ResultFuture<EmployeesFiltersEntity> call(NoParams params) {
    return repository.getEmployeesFilters();
  }
}
