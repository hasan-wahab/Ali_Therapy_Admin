import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT ENTITY (Domain)
// ------------------------------------------------------------
// One row from GET /api/admin/patients
// ============================================================

class PatientEntity extends Equatable {
  const PatientEntity({
    required this.id,
    required this.name,
    required this.cnic,
    this.problems = const [],
    this.insurance = '',
    this.totalBilled = 0,
    this.paid = 0,
    this.discount = 0,
    this.insuranceAmount = 0,
    this.remaining = 0,
    this.remainingSessions = 0,
    this.totalSessions = 0,
    this.createdBy = '',
    this.receptionist = '',
    this.assistantManager = '',
    this.historyTaker = '',
    this.consultant = '',
    this.therapist = '',
    this.createdAt = '',
  });

  final String id;
  final String name;
  final String cnic;
  final List<String> problems;
  final String insurance;
  final double totalBilled;
  final double paid;
  final double discount;
  final double insuranceAmount;
  final double remaining;
  final int remainingSessions;
  final int totalSessions;
  final String createdBy;
  final String receptionist;
  final String assistantManager;
  final String historyTaker;
  final String consultant;
  final String therapist;
  final String createdAt;

  @override
  List<Object?> get props => [
        id,
        name,
        cnic,
        problems,
        insurance,
        totalBilled,
        paid,
        discount,
        insuranceAmount,
        remaining,
        remainingSessions,
        totalSessions,
        createdBy,
        receptionist,
        assistantManager,
        historyTaker,
        consultant,
        therapist,
        createdAt,
      ];
}
