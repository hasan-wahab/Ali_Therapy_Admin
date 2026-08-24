import 'package:ali_therapy_admin/core/datasources/edit_employee/edit_employee_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/edit_employee_domain/entities/edit_employee_entity.dart';
import '../../../domain/edit_employee_domain/entities/edit_employee_form_entity.dart';
import '../../../domain/edit_employee_domain/entities/edit_employee_options_entity.dart';
import '../../../domain/edit_employee_domain/entities/update_employee_entity.dart';
import '../../../domain/edit_employee_domain/repositories/edit_employee_repository.dart';

// ============================================================
// EDIT EMPLOYEE REPOSITORY IMPLEMENTATION (Data)
// ============================================================

class EditEmployeeRepositoryImpl implements EditEmployeeRepository {
  EditEmployeeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final EditEmployeeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<EditEmployeeEntity> getEditEmployee({
    required String employeeId,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'EditEmployeeRepository.getEditEmployee',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.getEditEmployee(
        employeeId: employeeId,
      );
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'EditEmployeeRepository.getEditEmployee',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'EditEmployeeRepository.getEditEmployee',
      );
      return Result.failure(failure);
    }
  }

  @override
  ResultFuture<UpdateEmployeeEntity> updateEmployee({
    required String employeeId,
    required EditEmployeeFormEntity form,
    required EditEmployeeOptionsEntity options,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'EditEmployeeRepository.updateEmployee',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.updateEmployee(
        employeeId: employeeId,
        form: form,
        options: options,
      );
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'EditEmployeeRepository.updateEmployee',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'EditEmployeeRepository.updateEmployee',
      );
      return Result.failure(failure);
    }
  }
}
