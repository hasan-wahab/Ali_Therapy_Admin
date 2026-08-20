import 'package:equatable/equatable.dart';

import 'package_attendance_package_entity.dart';

// ============================================================
// PACKAGE ATTENDANCE ENTITY (Domain)
// ------------------------------------------------------------
// One patient row from GET /api/admin/reports/package-attendance
// ============================================================

class PackageAttendanceEntity extends Equatable {
  const PackageAttendanceEntity({
    required this.id,
    required this.patientName,
    required this.mrNo,
    required this.gender,
    required this.patientPhone,
    required this.hasNfc,
    required this.patientCnic,
    required this.packages,
  });

  final String id;
  final String patientName;
  final String mrNo;
  final String gender;
  final String patientPhone;
  final bool hasNfc;
  final String patientCnic;
  final List<PackageAttendancePackageEntity> packages;

  int get packagesTaken => packages.length;

  /// Prefer an active package for the list-card progress block.
  PackageAttendancePackageEntity? get featuredPackage {
    for (final package in packages) {
      if (package.isActive) return package;
    }
    if (packages.isEmpty) return null;
    return packages.first;
  }

  @override
  List<Object?> get props => [
        id,
        patientName,
        mrNo,
        gender,
        patientPhone,
        hasNfc,
        patientCnic,
        packages,
      ];
}
