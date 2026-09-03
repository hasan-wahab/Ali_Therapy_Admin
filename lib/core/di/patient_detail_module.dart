import 'package:ali_therapy_admin/core/datasources/patients/patients_remote_data_source.dart';
import 'package:ali_therapy_admin/core/di/di_module.dart';
import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/data/patient_detail_data/repositories/patient_detail_repository_impl.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/repositories/patient_detail_repository.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/usecases/get_patient_detail_usecase.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/bloc/patient_detail_bloc/patient_detail_bloc.dart';

// ============================================================
// PATIENT DETAIL MODULE (DI)
// ------------------------------------------------------------
// Reuses PatientsRemoteDataSource from All Patients.
// Order: repository → use case → bloc
// ============================================================

class PatientDetailModule implements DiModule {
  @override
  Future<void> register() async {
    sl.registerLazySingleton<PatientDetailRepository>(
      () => PatientDetailRepositoryImpl(
        remoteDataSource: sl<PatientsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetPatientDetailUseCase(sl<PatientDetailRepository>()),
    );

    // Factory = fresh bloc when opening View (one API load).
    sl.registerFactory(
      () => PatientDetailBloc(
        getPatientDetailUseCase: sl<GetPatientDetailUseCase>(),
      ),
    );
  }
}
