import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/entities/package_attendance_detail_entity.dart';

// ============================================================
// PACKAGE ATTENDANCE DETAIL REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class PackageAttendanceDetailRepository {
  ResultFuture<PackageAttendanceDetailEntity> getPackageAttendanceDetail({
    required String patientId,
  });
}
