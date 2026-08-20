import 'package:equatable/equatable.dart';

// ============================================================
// THERAPIST REPORT ENTITY (Domain)
// ------------------------------------------------------------
// One row from GET /api/admin/reports/therapist
// ============================================================

class TherapistReportEntity extends Equatable {
  const TherapistReportEntity({
    required this.id,
    required this.visitDate,
    required this.patientName,
    required this.patientPhone,
    required this.patientCnic,
    required this.therapistName,
    required this.consultantName,
    required this.clinicName,
    required this.status,
  });

  final String id;
  final String visitDate;
  final String patientName;
  final String patientPhone;
  final String patientCnic;
  final String therapistName;
  final String consultantName;
  final String clinicName;
  final String status;

  bool get isCompleted => status.toLowerCase() == 'completed';

  bool get isPending => status.toLowerCase() == 'pending';

  @override
  List<Object?> get props => [
        id,
        visitDate,
        patientName,
        patientPhone,
        patientCnic,
        therapistName,
        consultantName,
        clinicName,
        status,
      ];
}
