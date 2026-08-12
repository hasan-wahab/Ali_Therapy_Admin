import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/edit_employee_domain/entities/edit_employee_entity.dart';
import '../../../domain/edit_employee_domain/repositories/edit_employee_repository.dart';

// ============================================================
// EDITEMPLOYEE REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class EditEmployeeRepositoryImpl implements EditEmployeeRepository {
  EditEmployeeRepositoryImpl();

  @override
  ResultFuture<EditEmployeeEntity> getEditEmployee() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('EditEmployee API not integrated yet.'),
    );
  }
}
