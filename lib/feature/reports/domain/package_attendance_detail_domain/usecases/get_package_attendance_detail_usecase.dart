import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/entities/package_attendance_detail_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/repositories/package_attendance_detail_repository.dart';

// ============================================================
// GET PACKAGE ATTENDANCE DETAIL USE CASE
// ------------------------------------------------------------
// One job: fetch packages + attendance for one patient.
// ============================================================

class GetPackageAttendanceDetailUseCase
    extends UseCase<PackageAttendanceDetailEntity, String> {
  GetPackageAttendanceDetailUseCase(this.repository);

  final PackageAttendanceDetailRepository repository;

  @override
  ResultFuture<PackageAttendanceDetailEntity> call(String params) {
    return repository.getPackageAttendanceDetail(patientId: params);
  }
}
