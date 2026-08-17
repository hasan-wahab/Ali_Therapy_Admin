import 'package:ali_therapy_admin/core/datasources/profile/profile_remote_data_source.dart';
import 'package:ali_therapy_admin/core/datasources/profile/profile_remote_data_source_impl.dart';
import 'package:ali_therapy_admin/core/di/di_module.dart';
import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/feature/employee/profile/data/profile_data/repositories/profile_repository_impl.dart';
import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/repositories/profile_repository.dart';
import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/usecases/get_profile_usecase.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

// ============================================================
// PROFILE MODULE (DI)
// ------------------------------------------------------------
// Order: data source → repository → use case → bloc
// ============================================================

class ProfileModule implements DiModule {
  @override
  Future<void> register() async {
    sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(dioClient: sl<DioClient>()),
    );

    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        remoteDataSource: sl<ProfileRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetProfileUseCase(sl<ProfileRepository>()),
    );

    // Factory = fresh bloc when opening View (one API load).
    sl.registerFactory(
      () => ProfileBloc(getProfileUseCase: sl<GetProfileUseCase>()),
    );
  }
}