import 'package:ali_therapy_admin/core/datasources/auth/auth_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../../../domain/forget_password_domain/entities/forget_password_entity.dart';
import '../../../domain/forget_password_domain/repositories/forget_password_repository.dart';

// ============================================================
// FORGET PASSWORD REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Flow:
//   1. Check internet
//   2. Call AuthRemoteDataSource.forgetPassword
//   3. Model → Entity (or Failure)
// ============================================================

class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  ForgetPasswordRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<ForgetPasswordEntity> requestReset({
    required String email,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(failure, where: 'ForgetPasswordRepository');
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.forgetPassword(email: email);
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      return Result.failure(ErrorMapper.toFailure(e));
    } catch (e) {
      return Result.failure(ErrorMapper.fromUnknown(e));
    }
  }
}
