import 'package:ali_therapy_admin/core/datasources/reports/reports_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/entities/package_attendance_detail_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/repositories/package_attendance_detail_repository.dart';

// ============================================================
// PACKAGE ATTENDANCE DETAIL REPOSITORY IMPL (Data)
// ============================================================

class PackageAttendanceDetailRepositoryImpl
    implements PackageAttendanceDetailRepository {
  PackageAttendanceDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final ReportsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<PackageAttendanceDetailEntity> getPackageAttendanceDetail({
    required String patientId,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'PackageAttendanceDetailRepository.getPackageAttendanceDetail',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.getPackageAttendanceDetail(
        patientId: patientId,
      );
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'PackageAttendanceDetailRepository.getPackageAttendanceDetail',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'PackageAttendanceDetailRepository.getPackageAttendanceDetail',
      );
      return Result.failure(failure);
    }
  }
}
