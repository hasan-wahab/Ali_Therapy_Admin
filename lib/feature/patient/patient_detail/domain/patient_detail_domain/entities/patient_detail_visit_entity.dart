import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT DETAIL VISIT (Domain)
// ------------------------------------------------------------
// API: data.visits[]
// ============================================================

class PatientDetailVisitEntity extends Equatable {
  const PatientDetailVisitEntity({
    this.id = '',
    this.date = '',
    this.type = '',
    this.doctor = '',
    this.stage = '',
    this.amount = 0,
  });

  final String id;
  final String date;
  final String type;
  final String doctor;
  final String stage;
  final double amount;

  @override
  List<Object?> get props => [id, date, type, doctor, stage, amount];
}
