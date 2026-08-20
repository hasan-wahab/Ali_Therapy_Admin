import 'package:ali_therapy_admin/core/datasources/reports/reports_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/repositories/report_filter_options_repository.dart';

// ============================================================
// REPORT FILTER OPTIONS REPOSITORY IMPL (Data)
// ============================================================

class ReportFilterOptionsRepositoryImpl
    implements ReportFilterOptionsRepository {
  ReportFilterOptionsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final ReportsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<ReportFilterOptionsEntity> getFilterOptions() async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'ReportFilterOptionsRepository.getFilterOptions',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.getFilterOptions();
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'ReportFilterOptionsRepository.getFilterOptions',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'ReportFilterOptionsRepository.getFilterOptions',
      );
      return Result.failure(failure);
    }
  }
}
