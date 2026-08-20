import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../entities/employees_list_query.dart';
import '../entities/employees_page_entity.dart';
import '../repositories/all_employees_repository.dart';

// ============================================================
// GET ALL EMPLOYEES USE CASE
// ------------------------------------------------------------
// One job: load one employees page (with search + filters).
// ============================================================

class GetAllEmployeesUseCase
    extends UseCase<EmployeesPageEntity, EmployeesListQuery> {
  GetAllEmployeesUseCase(this.repository);

  final AllEmployeesRepository repository;

  @override
  ResultFuture<EmployeesPageEntity> call(EmployeesListQuery params) {
    return repository.getEmployeesPage(query: params);
  }
}
