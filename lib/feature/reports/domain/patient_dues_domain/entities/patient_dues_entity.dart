import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT DUES ENTITY (Domain)
// ------------------------------------------------------------
// One row from GET /api/admin/reports/patient-dues
// ============================================================

class PatientDuesEntity extends Equatable {
  const PatientDuesEntity({
    required this.id,
    required this.patientName,
    required this.patientCnic,
    required this.patientPhone,
    required this.receptionistName,
    required this.consultationBilled,
    required this.packageBilled,
    required this.grossBilled,
    required this.directDiscount,
    required this.insuranceDiscount,
    required this.totalDiscount,
    required this.totalPaid,
    required this.totalDue,
  });

  final String id;
  final String patientName;
  final String patientCnic;
  final String patientPhone;
  final String receptionistName;
  final double consultationBilled;
  final double packageBilled;
  final double grossBilled;
  final double directDiscount;
  final double insuranceDiscount;
  final double totalDiscount;
  final double totalPaid;
  final double totalDue;

  @override
  List<Object?> get props => [
        id,
        patientName,
        patientCnic,
        patientPhone,
        receptionistName,
        consultationBilled,
        packageBilled,
        grossBilled,
        directDiscount,
        insuranceDiscount,
        totalDiscount,
        totalPaid,
        totalDue,
      ];
}
