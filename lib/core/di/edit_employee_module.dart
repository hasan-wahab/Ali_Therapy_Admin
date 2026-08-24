import 'package:ali_therapy_admin/core/datasources/edit_employee/edit_employee_remote_data_source.dart';
import 'package:ali_therapy_admin/core/datasources/edit_employee/edit_employee_remote_data_source_impl.dart';
import 'package:ali_therapy_admin/core/di/di_module.dart';
import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/data/edit_employee_data/repositories/edit_employee_repository_impl.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/repositories/edit_employee_repository.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/usecases/get_edit_employee_usecase.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/usecases/update_employee_usecase.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/bloc/edit_employee_bloc/edit_employee_bloc.dart';

// ============================================================
// EDIT EMPLOYEE MODULE (DI)
// ------------------------------------------------------------
// Order: data source → repository → use case → bloc
// ============================================================

class EditEmployeeModule implements DiModule {
  @override
  Future<void> register() async {
    sl.registerLazySingleton<EditEmployeeRemoteDataSource>(
      () => EditEmployeeRemoteDataSourceImpl(dioClient: sl<DioClient>()),
    );

    sl.registerLazySingleton<EditEmployeeRepository>(
      () => EditEmployeeRepositoryImpl(
        remoteDataSource: sl<EditEmployeeRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetEditEmployeeUseCase(sl<EditEmployeeRepository>()),
    );
    sl.registerLazySingleton(
      () => UpdateEmployeeUseCase(sl<EditEmployeeRepository>()),
    );

    sl.registerFactory(
      () => EditEmployeeBloc(
        getEditEmployeeUseCase: sl<GetEditEmployeeUseCase>(),
        updateEmployeeUseCase: sl<UpdateEmployeeUseCase>(),
      ),
    );
  }
}
