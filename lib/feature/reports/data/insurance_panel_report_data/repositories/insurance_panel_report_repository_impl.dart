import 'package:ali_therapy_admin/core/datasources/reports/reports_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_result_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/repositories/insurance_panel_report_repository.dart';

// ============================================================
// INSURANCE PANEL REPORT REPOSITORY IMPL (Data)
// ============================================================

class InsurancePanelReportRepositoryImpl
    implements InsurancePanelReportRepository {
  InsurancePanelReportRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final ReportsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<InsurancePanelReportResultEntity> getInsurancePanelReport({
    required InsurancePanelReportQuery query,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'InsurancePanelReportRepository.getInsurancePanelReport',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.getInsurancePanelReport(query: query);
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'InsurancePanelReportRepository.getInsurancePanelReport',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'InsurancePanelReportRepository.getInsurancePanelReport',
      );
      return Result.failure(failure);
    }
  }
}
