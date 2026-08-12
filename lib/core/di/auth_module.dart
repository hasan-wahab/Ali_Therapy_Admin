import 'package:ali_therapy_admin/core/datasources/auth/auth_remote_data_source.dart';
import 'package:ali_therapy_admin/core/datasources/auth/auth_remote_data_source_impl.dart';
import 'package:ali_therapy_admin/core/di/di_module.dart';
import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/services/auth_local_storage.dart';
import 'package:ali_therapy_admin/feature/auth/data/change_password_data/repositories/change_password_repository_impl.dart';
import 'package:ali_therapy_admin/feature/auth/data/forget_password_data/repositories/forget_password_repository_impl.dart';
import 'package:ali_therapy_admin/feature/auth/data/login_data/repositories/auth_repository_impl.dart';
import 'package:ali_therapy_admin/feature/auth/domain/change_password_domain/repositories/change_password_repository.dart';
import 'package:ali_therapy_admin/feature/auth/domain/change_password_domain/usecases/change_password_usecase.dart';
import 'package:ali_therapy_admin/feature/auth/domain/forget_password_domain/repositories/forget_password_repository.dart';
import 'package:ali_therapy_admin/feature/auth/domain/forget_password_domain/usecases/forget_password_usecase.dart';
import 'package:ali_therapy_admin/feature/auth/domain/login_domain/repositories/auth_repository.dart';
import 'package:ali_therapy_admin/feature/auth/domain/login_domain/usecases/login_usecase.dart';
import 'package:ali_therapy_admin/feature/auth/domain/login_domain/usecases/logout_usecase.dart';
import 'package:ali_therapy_admin/feature/auth/domain/login_domain/usecases/restore_session_usecase.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/bloc/change_password_bloc/change_password_bloc.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/bloc/login_bloc/auth_bloc.dart';

// ============================================================
// AUTH MODULE (DI)
// ------------------------------------------------------------
// Registers everything needed by the auth feature.
// Order: data source → repository → use cases → bloc
// ============================================================

class AuthModule implements DiModule {
  @override
  Future<void> register() async {
    // Data sources (API only)
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dioClient: sl<DioClient>()),
    );

    // Repositories
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl<AuthRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
        localStorage: sl<AuthLocalStorage>(),
      ),
    );
    sl.registerLazySingleton<ForgetPasswordRepository>(
      () => ForgetPasswordRepositoryImpl(
        remoteDataSource: sl<AuthRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );
    sl.registerLazySingleton<ChangePasswordRepository>(
      () => ChangePasswordRepositoryImpl(
        remoteDataSource: sl<AuthRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    // Use cases
    sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
    sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));
    sl.registerLazySingleton(() => RestoreSessionUseCase(sl<AuthRepository>()));
    sl.registerLazySingleton(
      () => ForgetPasswordUseCase(sl<ForgetPasswordRepository>()),
    );
    sl.registerLazySingleton(
      () => ChangePasswordUseCase(sl<ChangePasswordRepository>()),
    );

    // BLoCs — factory = fresh instance per page
    sl.registerFactory(
      () => AuthBloc(
        loginUseCase: sl<LoginUseCase>(),
        logoutUseCase: sl<LogoutUseCase>(),
        restoreSessionUseCase: sl<RestoreSessionUseCase>(),
      ),
    );
    sl.registerFactory(
      () => ForgetPasswordBloc(
        forgetPasswordUseCase: sl<ForgetPasswordUseCase>(),
      ),
    );
    sl.registerFactory(
      () => ChangePasswordBloc(
        changePasswordUseCase: sl<ChangePasswordUseCase>(),
      ),
    );
  }
}
