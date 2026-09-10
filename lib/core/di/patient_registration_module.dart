import 'package:shared_preferences/shared_preferences.dart';

import 'package:ali_therapy_admin/core/datasources/patients/patients_remote_data_source.dart';
import 'package:ali_therapy_admin/core/di/di_module.dart';
import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/patient_form_data_local_storage.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/repositories/patient_registration_repository_impl.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/repositories/patient_registration_repository.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/usecases/create_patient_usecase.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/usecases/get_patient_details_usecase.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/usecases/get_patient_form_data_usecase.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/bloc/patient_registration_bloc/patient_registration_bloc.dart';

// ============================================================
// PATIENT REGISTRATION MODULE (DI)
// ------------------------------------------------------------
// Reuses PatientsRemoteDataSource from All Patients.
// Order: repository → use case → bloc
// ============================================================

class PatientRegistrationModule implements DiModule {
  @override
  Future<void> register() async {
    sl.registerLazySingleton(
      () => PatientFormDataLocalStorage(sl<SharedPreferences>()),
    );

    sl.registerLazySingleton<PatientRegistrationRepository>(
      () => PatientRegistrationRepositoryImpl(
        remoteDataSource: sl<PatientsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
        formDataLocalStorage: sl<PatientFormDataLocalStorage>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetPatientFormDataUseCase(sl<PatientRegistrationRepository>()),
    );
    sl.registerLazySingleton(
      () => GetPatientDetailsUseCase(sl<PatientRegistrationRepository>()),
    );
    sl.registerLazySingleton(
      () => CreatePatientUseCase(sl<PatientRegistrationRepository>()),
    );

    sl.registerFactory(
      () => PatientRegistrationBloc(
        getPatientFormDataUseCase: sl<GetPatientFormDataUseCase>(),
        getPatientDetailsUseCase: sl<GetPatientDetailsUseCase>(),
        createPatientUseCase: sl<CreatePatientUseCase>(),
      ),
    );
  }
}
