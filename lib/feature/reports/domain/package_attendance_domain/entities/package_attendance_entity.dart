import 'package:equatable/equatable.dart';

// ============================================================
// PACKAGEATTENDANCE ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class PackageAttendanceEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const PackageAttendanceEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
