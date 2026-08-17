import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../entities/employees_page_entity.dart';
import '../repositories/all_employees_repository.dart';

// ============================================================
// GET ALL EMPLOYEES USE CASE
// ------------------------------------------------------------
// One job: load one employees page.
// ============================================================

class GetEmployeesPageParams {
  const GetEmployeesPageParams({required this.page});

  final int page;
}

class GetAllEmployeesUseCase
    extends UseCase<EmployeesPageEntity, GetEmployeesPageParams> {
  final AllEmployeesRepository repository;

  GetAllEmployeesUseCase(this.repository);

  @override
  ResultFuture<EmployeesPageEntity> call(GetEmployeesPageParams params) {
    return repository.getEmployeesPage(page: params.page);
  }
}
