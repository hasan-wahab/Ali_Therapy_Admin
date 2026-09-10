import 'package:ali_therapy_admin/core/datasources/patients/patients_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/patient_form_data_local_storage.dart';

import '../../../domain/patient_registration_domain/entities/create_patient_entity.dart';
import '../../../domain/patient_registration_domain/entities/patient_create_form_entity.dart';
import '../../../domain/patient_registration_domain/entities/patient_form_data_entity.dart';
import '../../../domain/patient_registration_domain/repositories/patient_registration_repository.dart';

// ============================================================
// PATIENT REGISTRATION REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Form-data: local cache first, API only on first Create Patient.
// ============================================================

class PatientRegistrationRepositoryImpl
    implements PatientRegistrationRepository {
  PatientRegistrationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.formDataLocalStorage,
  });

  final PatientsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final PatientFormDataLocalStorage formDataLocalStorage;

  @override
  ResultFuture<PatientFormDataEntity> getFormData() async {
    final cached = formDataLocalStorage.read();
    if (cached != null) {
      return Result.success(cached.toEntity());
    }

    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientRegistrationRepository.getFormData',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.getPatientFormData();
      await formDataLocalStorage.save(model);
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientRegistrationRepository.getFormData',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientRegistrationRepository.getFormData',
      );
      return Result.failure(failure);
    }
  }

  @override
  ResultFuture<PatientCreateFormEntity> getPatientDetails({
    required String patientId,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientRegistrationRepository.getPatientDetails',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.getPatientDetails(
        patientId: patientId,
      );
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientRegistrationRepository.getPatientDetails',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientRegistrationRepository.getPatientDetails',
      );
      return Result.failure(failure);
    }
  }

  @override
  ResultFuture<CreatePatientEntity> createPatient({
    required PatientCreateFormEntity form,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientRegistrationRepository.createPatient',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.createPatient(form: form);
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientRegistrationRepository.createPatient',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'PatientRegistrationRepository.createPatient',
      );
      return Result.failure(failure);
    }
  }
}
