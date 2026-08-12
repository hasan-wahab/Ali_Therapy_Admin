import 'package:ali_therapy_admin/core/datasources/auth/auth_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/services/auth_local_storage.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../../../domain/login_domain/entities/login_entity.dart';
import '../../../domain/login_domain/repositories/auth_repository.dart';

// ============================================================
// AUTH REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Flow (login):
//   1. Check internet
//   2. Call remote data source (API)
//   3. Save token + login JSON locally
//   4. Return LoginEntity (or Failure)
// ============================================================

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localStorage,
  });

  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final AuthLocalStorage localStorage;

  @override
  ResultFuture<LoginEntity> login({
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(failure, where: 'AuthRepository.login');
      return Result.failure(failure);
    }

    try {
      final loginModel = await remoteDataSource.login(
        email: email,
        password: password,
      );

      await localStorage.saveLogin(loginModel);

      return Result.success(loginModel.toEntity());
    } on AppException catch (e) {
      return Result.failure(ErrorMapper.toFailure(e));
    } catch (e) {
      return Result.failure(ErrorMapper.fromUnknown(e));
    }
  }

  @override
  ResultVoid logout() async {
    try {
      // Best-effort server logout (needs Bearer token from storage).
      await remoteDataSource.logout();
    } catch (_) {
      // Ignore API errors — we still clear local session below.
    }

    try {
      await localStorage.clear();
      return Result.success(null);
    } catch (e) {
      return Result.failure(ErrorMapper.fromUnknown(e));
    }
  }

  @override
  ResultFuture<LoginEntity?> restoreSession() async {
    try {
      final saved = await localStorage.getSavedLogin();
      if (saved == null) {
        return Result.success(null);
      }
      return Result.success(saved.toEntity());
    } catch (e) {
      // Broken local data → force login again.
      await localStorage.clear();
      return Result.success(null);
    }
  }
}
