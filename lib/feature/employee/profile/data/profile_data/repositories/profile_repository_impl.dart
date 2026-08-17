import 'package:ali_therapy_admin/core/datasources/profile/profile_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/profile_domain/entities/profile_entity.dart';
import '../../../domain/profile_domain/repositories/profile_repository.dart';

// ============================================================
// PROFILE REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Flow: network check → remote DS → model → entity
// ============================================================

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<ProfileEntity> getProfile({required String employeeId}) async {
    if (!await networkInfo.isConnected) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'ProfileRepository.getProfile',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.getProfile(employeeId: employeeId);
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'ProfileRepository.getProfile',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'ProfileRepository.getProfile',
      );
      return Result.failure(failure);
    }
  }
}
