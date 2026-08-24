import 'package:ali_therapy_admin/core/datasources/home/home_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_entity.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_overview_query.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/repositories/home_repository.dart';

// ============================================================
// HOME REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// 1. Check internet
// 2. Call GET dashboard/overview
// 3. Map model → entity
// ============================================================

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<DashboardEntity> getDashboard({
    required DashboardOverviewQuery query,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'HomeRepository.getDashboard',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.getOverview(query: query);
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'HomeRepository.getDashboard',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'HomeRepository.getDashboard',
      );
      return Result.failure(failure);
    }
  }
}
