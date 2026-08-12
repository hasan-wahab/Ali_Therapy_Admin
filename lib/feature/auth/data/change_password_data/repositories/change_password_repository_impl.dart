import 'package:ali_therapy_admin/core/datasources/auth/auth_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../../../domain/change_password_domain/entities/change_password_entity.dart';
import '../../../domain/change_password_domain/repositories/change_password_repository.dart';

// ============================================================
// CHANGE PASSWORD REPOSITORY IMPLEMENTATION (Data)
// ============================================================

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  ChangePasswordRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<ChangePasswordEntity> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (!await networkInfo.isConnected) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(failure, where: 'ChangePasswordRepository');
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      return Result.failure(ErrorMapper.toFailure(e));
    } catch (e) {
      return Result.failure(ErrorMapper.fromUnknown(e));
    }
  }
}
