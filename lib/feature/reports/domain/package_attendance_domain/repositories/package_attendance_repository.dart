import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/entities/package_attendance_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/entities/package_attendance_query.dart';

// ============================================================
// PACKAGE ATTENDANCE REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class PackageAttendanceRepository {
  ResultFuture<PackageAttendancePageEntity> getPackageAttendancePage({
    required PackageAttendanceQuery query,
  });
}
