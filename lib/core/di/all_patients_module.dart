import 'package:ali_therapy_admin/core/datasources/patients/patients_remote_data_source.dart';
import 'package:ali_therapy_admin/core/datasources/patients/patients_remote_data_source_impl.dart';
import 'package:ali_therapy_admin/core/di/di_module.dart';
import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/data/all_patients_data/repositories/all_patients_repository_impl.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/domain/all_patients_domain/repositories/all_patients_repository.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/domain/all_patients_domain/usecases/get_all_patients_usecase.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/bloc/all_patients_bloc/all_patients_bloc.dart';

// ============================================================
// ALL PATIENTS MODULE (DI)
// ------------------------------------------------------------
// Order: data source → repository → use case → bloc
// ============================================================

class AllPatientsModule implements DiModule {
  @override
  Future<void> register() async {
    sl.registerLazySingleton<PatientsRemoteDataSource>(
      () => PatientsRemoteDataSourceImpl(dioClient: sl<DioClient>()),
    );

    sl.registerLazySingleton<AllPatientsRepository>(
      () => AllPatientsRepositoryImpl(
        remoteDataSource: sl<PatientsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetAllPatientsUseCase(sl<AllPatientsRepository>()),
    );

    sl.registerFactory(
      () => AllPatientsBloc(
        getAllPatientsUseCase: sl<GetAllPatientsUseCase>(),
      ),
    );
  }
}
