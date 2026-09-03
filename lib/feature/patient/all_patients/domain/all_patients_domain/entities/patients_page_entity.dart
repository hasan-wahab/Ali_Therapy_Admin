import 'package:equatable/equatable.dart';

import 'patient_entity.dart';

// ============================================================
// PATIENTS PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One Laravel paginate page from GET /api/admin/patients
// ============================================================

class PatientsPageEntity extends Equatable {
  const PatientsPageEntity({
    required this.patients,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  final List<PatientEntity> patients;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [patients, currentPage, lastPage, perPage, total];
}
