import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/package_attendance_domain/entities/package_attendance_entity.dart';
import '../../../domain/package_attendance_domain/repositories/package_attendance_repository.dart';

// ============================================================
// PACKAGEATTENDANCE REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class PackageAttendanceRepositoryImpl implements PackageAttendanceRepository {
  PackageAttendanceRepositoryImpl();

  @override
  ResultFuture<PackageAttendanceEntity> getPackageAttendance() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('PackageAttendance API not integrated yet.'),
    );
  }
}
