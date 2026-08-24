import 'package:ali_therapy_admin/core/datasources/home/home_remote_data_source.dart';
import 'package:ali_therapy_admin/core/datasources/home/home_remote_data_source_impl.dart';
import 'package:ali_therapy_admin/core/di/di_module.dart';
import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/feature/home/data/home_data/repositories/home_repository_impl.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/repositories/home_repository.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/usecases/get_dashboard_usecase.dart';
import 'package:ali_therapy_admin/feature/home/presentation/bloc/home_bloc/home_bloc.dart';

// ============================================================
// HOME MODULE (DI)
// ------------------------------------------------------------
// Order: data source → repository → use case → bloc
// ============================================================

class HomeModule implements DiModule {
  @override
  Future<void> register() async {
    sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(dioClient: sl<DioClient>()),
    );

    sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        remoteDataSource: sl<HomeRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetDashboardUseCase(sl<HomeRepository>()),
    );

    sl.registerFactory(
      () => HomeBloc(getDashboardUseCase: sl<GetDashboardUseCase>()),
    );
  }
}
