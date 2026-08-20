import 'package:ali_therapy_admin/core/datasources/all_employees/all_employees_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/all_employees_domain/entities/assign_employee_biometric_id_entity.dart';
import '../../../domain/all_employees_domain/entities/assign_employee_device_id_entity.dart';
import '../../../domain/all_employees_domain/entities/change_employee_password_entity.dart';
import '../../../domain/all_employees_domain/entities/employees_filters_entity.dart';
import '../../../domain/all_employees_domain/entities/employees_list_query.dart';
import '../../../domain/all_employees_domain/entities/employees_page_entity.dart';
import '../../../domain/all_employees_domain/entities/terminate_employee_entity.dart';
import '../../../domain/all_employees_domain/entities/toggle_status_entity.dart';
import '../../../domain/all_employees_domain/repositories/all_employees_repository.dart';

// ============================================================
// ALLEMPLOYEES REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Flow:
//   1. Check internet
//   2. Call remote data source (API page)
//   3. Map model → entity
// ============================================================

class AllEmployeesRepositoryImpl implements AllEmployeesRepository {
  AllEmployeesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final AllEmployeesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<EmployeesPageEntity> getEmployeesPage({
    required EmployeesListQuery query,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.getEmployeesPage',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.getEmployeesPage(query: query);
      // Keep API order as-is (no id sort, no reverse).
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.getEmployeesPage',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.getEmployeesPage',
      );
      return Result.failure(failure);
    }
  }

  @override
  ResultFuture<EmployeesFiltersEntity> getEmployeesFilters() async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.getEmployeesFilters',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.getEmployeesFilters();
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.getEmployeesFilters',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.getEmployeesFilters',
      );
      return Result.failure(failure);
    }
  }

  @override
  ResultFuture<ToggleStatusEntity> toggleEmployeeStatus({
    required String employeeId,
    required bool newStatus,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.toggleEmployeeStatus',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.toggleEmployeeStatus(
        employeeId: employeeId,
        newStatus: newStatus,
      );
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.toggleEmployeeStatus',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.toggleEmployeeStatus',
      );
      return Result.failure(failure);
    }
  }

  @override
  ResultFuture<TerminateEmployeeEntity> terminateEmployee({
    required String employeeId,
    required String reason,
    required String date,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.terminateEmployee',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.terminateEmployee(
        employeeId: employeeId,
        reason: reason,
        date: date,
      );
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.terminateEmployee',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.terminateEmployee',
      );
      return Result.failure(failure);
    }
  }

  @override
  ResultFuture<ChangeEmployeePasswordEntity> changeEmployeePassword({
    required String employeeId,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.changeEmployeePassword',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.changeEmployeePassword(
        employeeId: employeeId,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.changeEmployeePassword',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.changeEmployeePassword',
      );
      return Result.failure(failure);
    }
  }

  @override
  ResultFuture<AssignEmployeeDeviceIdEntity> assignEmployeeDeviceId({
    required String employeeId,
    required int deviceId,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.assignEmployeeDeviceId',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.assignEmployeeDeviceId(
        employeeId: employeeId,
        deviceId: deviceId,
      );
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.assignEmployeeDeviceId',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.assignEmployeeDeviceId',
      );
      return Result.failure(failure);
    }
  }

  @override
  ResultFuture<AssignEmployeeBiometricIdEntity> assignEmployeeBiometricId({
    required String employeeId,
    required String biometricId,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.assignEmployeeBiometricId',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.assignEmployeeBiometricId(
        employeeId: employeeId,
        biometricId: biometricId,
      );
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.assignEmployeeBiometricId',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.assignEmployeeBiometricId',
      );
      return Result.failure(failure);
    }
  }
}
