import 'package:equatable/equatable.dart';

import 'patient_dues_entity.dart';

// ============================================================
// PATIENT DUES PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One paginated page of patient dues rows.
// ============================================================

class PatientDuesPageEntity extends Equatable {
  const PatientDuesPageEntity({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  final List<PatientDuesEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total];
}
