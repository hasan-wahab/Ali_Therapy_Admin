import 'package:ali_therapy_admin/core/datasources/reports/reports_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/repositories/discount_report_repository.dart';

// ============================================================
// DISCOUNT REPORT REPOSITORY IMPL (Data)
// ============================================================

class DiscountReportRepositoryImpl implements DiscountReportRepository {
  DiscountReportRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final ReportsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<DiscountReportPageEntity> getDiscountReportPage({
    required DiscountReportQuery query,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'DiscountReportRepository.getDiscountReportPage',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.getDiscountReportPage(query: query);
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'DiscountReportRepository.getDiscountReportPage',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'DiscountReportRepository.getDiscountReportPage',
      );
      return Result.failure(failure);
    }
  }
}
