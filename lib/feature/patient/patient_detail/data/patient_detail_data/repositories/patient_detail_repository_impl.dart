import 'package:ali_therapy_admin/core/datasources/patients/patients_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/patient_detail_domain/entities/patient_detail_entity.dart';
import '../../../domain/patient_detail_domain/repositories/patient_detail_repository.dart';

// ============================================================
// PATIENT DETAIL REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Flow: network check → remote DS → model → entity
// ============================================================

class PatientDetailRepositoryImpl implements PatientDetailRepository {
  PatientDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final PatientsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<PatientDetailEntity> getPatientDetail({
    required String patientId,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientDetailRepository.getPatientDetail',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.getPatientFullView(
        patientId: patientId,
      );
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientDetailRepository.getPatientDetail',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientDetailRepository.getPatientDetail',
      );
      return Result.failure(failure);
    }
  }
}
