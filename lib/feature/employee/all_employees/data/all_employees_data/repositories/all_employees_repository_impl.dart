import 'package:ali_therapy_admin/core/datasources/all_employees/all_employees_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/all_employees_domain/entities/employee_entity.dart';
import '../../../domain/all_employees_domain/repositories/all_employees_repository.dart';

// ============================================================
// ALLEMPLOYEES REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Flow:
//   1. Check internet
//   2. Call remote data source (API)
//   3. Map models → entities
//   4. Return list (or Failure)
// ============================================================

class AllEmployeesRepositoryImpl implements AllEmployeesRepository {
  AllEmployeesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final AllEmployeesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<List<EmployeeEntity>> getAllEmployees() async {
    if (!await networkInfo.isConnected) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.getAllEmployees',
      );
      return Result.failure(failure);
    }

    try {
      final models = await remoteDataSource.getAllEmployees();
      final employees = models.map((model) => model.toEntity()).toList();

      // Descending by id — newest / last API items first on screen.
      employees.sort((a, b) {
        final idA = int.tryParse(a.id) ?? 0;
        final idB = int.tryParse(b.id) ?? 0;
        return idA.compareTo(idB);
      });

      return Result.success(employees);
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.getAllEmployees',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllEmployeesRepository.getAllEmployees',
      );
      return Result.failure(failure);
    }
  }
}
