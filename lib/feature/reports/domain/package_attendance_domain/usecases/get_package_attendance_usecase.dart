import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/package_attendance_entity.dart';
import '../repositories/package_attendance_repository.dart';

// ============================================================
// GET PACKAGEATTENDANCE USE CASE
// ------------------------------------------------------------
// One job: fetch package attendance data.
// ============================================================

class GetPackageAttendanceUseCase extends UseCase<PackageAttendanceEntity, NoParams> {
  final PackageAttendanceRepository repository;

  GetPackageAttendanceUseCase(this.repository);

  @override
  ResultFuture<PackageAttendanceEntity> call(NoParams params) {
    return repository.getPackageAttendance();
  }
}
