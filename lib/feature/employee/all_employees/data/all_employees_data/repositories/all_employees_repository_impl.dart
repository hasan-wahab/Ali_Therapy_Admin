import 'package:ali_therapy_admin/core/datasources/all_employees/all_employees_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/all_employees_domain/entities/employees_page_entity.dart';
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
    required int page,
  }) async {
    if (!await networkInfo.isConnected) {
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
      final model = await remoteDataSource.getEmployeesPage(page: page);
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
}
