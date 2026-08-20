import 'package:equatable/equatable.dart';

// ============================================================
// REPORT CLINIC OPTION ENTITY (Domain)
// ------------------------------------------------------------
// One clinic in a report filter dropdown.
// ============================================================

class ReportClinicOptionEntity extends Equatable {
  const ReportClinicOptionEntity({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
