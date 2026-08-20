import 'package:equatable/equatable.dart';

// ============================================================
// PACKAGE ATTENDANCE PACKAGE ENTITY (Domain)
// ------------------------------------------------------------
// One nested package from GET /reports/package-attendance
// ============================================================

class PackageAttendancePackageEntity extends Equatable {
  const PackageAttendancePackageEntity({
    required this.id,
    required this.packageName,
    required this.sessionsTotal,
    required this.sessionsUsed,
    required this.status,
  });

  final String id;
  final String packageName;
  final int sessionsTotal;
  final int sessionsUsed;
  final String status;

  bool get isActive => status.toLowerCase() == 'active';

  @override
  List<Object?> get props => [
        id,
        packageName,
        sessionsTotal,
        sessionsUsed,
        status,
      ];
}
