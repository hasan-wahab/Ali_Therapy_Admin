import 'package:equatable/equatable.dart';

import 'package_attendance_detail_package_entity.dart';

// ============================================================
// PACKAGE ATTENDANCE DETAIL ENTITY (Domain)
// ------------------------------------------------------------
// One patient from GET /reports/package-attendance/{patientId}
// ============================================================

class PackageAttendanceDetailEntity extends Equatable {
  const PackageAttendanceDetailEntity({
    required this.id,
    required this.patientName,
    required this.mrNo,
    required this.patientPhone,
    required this.packages,
  });

  final String id;
  final String patientName;
  final String mrNo;
  final String patientPhone;
  final List<PackageAttendanceDetailPackageEntity> packages;

  /// Prefer an active package, otherwise the first one.
  PackageAttendanceDetailPackageEntity? get featuredPackage {
    for (final package in packages) {
      if (package.isActive) return package;
    }
    if (packages.isEmpty) return null;
    return packages.first;
  }

  PackageAttendanceDetailPackageEntity? packageById(String packageId) {
    for (final package in packages) {
      if (package.id == packageId) return package;
    }
    return featuredPackage;
  }

  @override
  List<Object?> get props => [
        id,
        patientName,
        mrNo,
        patientPhone,
        packages,
      ];
}
