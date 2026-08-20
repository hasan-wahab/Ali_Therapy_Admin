import 'package:equatable/equatable.dart';

import 'package_attendance_entity.dart';

// ============================================================
// PACKAGE ATTENDANCE PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One paginated page of package attendance rows.
// ============================================================

class PackageAttendancePageEntity extends Equatable {
  const PackageAttendancePageEntity({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  final List<PackageAttendanceEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total];
}
