import 'package:ali_therapy_admin/core/datasources/all_employees/all_employees_remote_data_source.dart';
import 'package:ali_therapy_admin/core/datasources/all_employees/all_employees_remote_data_source_impl.dart';
import 'package:ali_therapy_admin/core/di/di_module.dart';
import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/repositories/all_employees_repository_impl.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/repositories/all_employees_repository.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/usecases/get_all_employees_usecase.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/bloc/all_employees_bloc/all_employees_bloc.dart';

// ============================================================
// ALL EMPLOYEES MODULE (DI)
// ------------------------------------------------------------
// Order: data source → repository → use case → bloc
// ============================================================

class AllEmployeesModule implements DiModule {
  @override
  Future<void> register() async {
    // Data source (API only)
    sl.registerLazySingleton<AllEmployeesRemoteDataSource>(
      () => AllEmployeesRemoteDataSourceImpl(dioClient: sl<DioClient>()),
    );

    // Repository
    sl.registerLazySingleton<AllEmployeesRepository>(
      () => AllEmployeesRepositoryImpl(
        remoteDataSource: sl<AllEmployeesRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    // Use case
    sl.registerLazySingleton(
      () => GetAllEmployeesUseCase(sl<AllEmployeesRepository>()),
    );

    // Bloc — factory = fresh instance per page
    sl.registerFactory(
      () => AllEmployeesBloc(
        getAllEmployeesUseCase: sl<GetAllEmployeesUseCase>(),
      ),
    );
  }
}
