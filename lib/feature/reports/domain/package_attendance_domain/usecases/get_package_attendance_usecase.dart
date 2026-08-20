import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/entities/package_attendance_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/entities/package_attendance_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/repositories/package_attendance_repository.dart';

// ============================================================
// GET PACKAGE ATTENDANCE USE CASE
// ------------------------------------------------------------
// One job: fetch paginated package attendance rows.
// ============================================================

class GetPackageAttendanceUseCase
    extends UseCase<PackageAttendancePageEntity, PackageAttendanceQuery> {
  GetPackageAttendanceUseCase(this.repository);

  final PackageAttendanceRepository repository;

  @override
  ResultFuture<PackageAttendancePageEntity> call(PackageAttendanceQuery params) {
    return repository.getPackageAttendancePage(query: params);
  }
}
