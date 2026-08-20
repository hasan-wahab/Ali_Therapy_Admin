import 'package:equatable/equatable.dart';

import 'package_attendance_session_entity.dart';

// ============================================================
// PACKAGE ATTENDANCE DETAIL PACKAGE ENTITY (Domain)
// ------------------------------------------------------------
// One purchased package on the detail screen.
// ============================================================

class PackageAttendanceDetailPackageEntity extends Equatable {
  const PackageAttendanceDetailPackageEntity({
    required this.id,
    required this.packageName,
    required this.purchasedDate,
    required this.sessionsTotal,
    required this.sessionsUsed,
    required this.status,
    required this.sessionsHistory,
  });

  final String id;
  final String packageName;
  final String purchasedDate;
  final int sessionsTotal;
  final int sessionsUsed;
  final String status;
  final List<PackageAttendanceSessionEntity> sessionsHistory;

  bool get isActive => status.toLowerCase() == 'active';

  int get remaining {
    final left = sessionsTotal - sessionsUsed;
    return left < 0 ? 0 : left;
  }

  @override
  List<Object?> get props => [
        id,
        packageName,
        purchasedDate,
        sessionsTotal,
        sessionsUsed,
        status,
        sessionsHistory,
      ];
}
