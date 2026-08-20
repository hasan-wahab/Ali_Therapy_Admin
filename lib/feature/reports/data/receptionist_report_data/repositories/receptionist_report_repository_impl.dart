import 'package:ali_therapy_admin/core/datasources/reports/reports_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/entities/receptionist_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/entities/receptionist_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/repositories/receptionist_report_repository.dart';

// ============================================================
// RECEPTIONIST REPORT REPOSITORY IMPL (Data)
// ============================================================

class ReceptionistReportRepositoryImpl implements ReceptionistReportRepository {
  ReceptionistReportRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final ReportsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<ReceptionistReportPageEntity> getReceptionistReportPage({
    required ReceptionistReportQuery query,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'ReceptionistReportRepository.getReceptionistReportPage',
      );
      return Result.failure(failure);
    }

    try {
      final model =
          await remoteDataSource.getReceptionistReportPage(query: query);
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'ReceptionistReportRepository.getReceptionistReportPage',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'ReceptionistReportRepository.getReceptionistReportPage',
      );
      return Result.failure(failure);
    }
  }
}
