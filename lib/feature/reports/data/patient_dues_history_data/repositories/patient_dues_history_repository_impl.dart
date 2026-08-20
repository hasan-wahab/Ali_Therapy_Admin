import 'package:ali_therapy_admin/core/datasources/reports/reports_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_history_domain/entities/patient_dues_history_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_history_domain/repositories/patient_dues_history_repository.dart';

// ============================================================
// PATIENT DUES HISTORY REPOSITORY IMPL (Data)
// ============================================================

class PatientDuesHistoryRepositoryImpl implements PatientDuesHistoryRepository {
  PatientDuesHistoryRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final ReportsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<List<PatientDuesHistoryEntity>> getPatientDuesHistory({
    required String patientId,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientDuesHistoryRepository.getPatientDuesHistory',
      );
      return Result.failure(failure);
    }

    try {
      final models = await remoteDataSource.getPatientDuesHistory(
        patientId: patientId,
      );
      return Result.success(
        models.map((row) => row.toEntity()).toList(),
      );
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientDuesHistoryRepository.getPatientDuesHistory',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientDuesHistoryRepository.getPatientDuesHistory',
      );
      return Result.failure(failure);
    }
  }
}
