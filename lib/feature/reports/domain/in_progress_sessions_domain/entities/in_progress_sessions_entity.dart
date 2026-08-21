import 'package:equatable/equatable.dart';

// ============================================================
// IN-PROGRESS SESSIONS ENTITY (Domain)
// ------------------------------------------------------------
// One row from GET /api/admin/reports/in-progress-sessions
// ============================================================

class InProgressSessionsEntity extends Equatable {
  const InProgressSessionsEntity({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.patientCnic,
    required this.mrNo,
    required this.sessionTypes,
    required this.consultantName,
    required this.therapistName,
    required this.clinicName,
    required this.startTime,
    required this.status,
  });

  final String id;
  final String patientId;
  final String patientName;
  final String patientCnic;
  final String mrNo;
  final List<String> sessionTypes;
  final String consultantName;
  final String therapistName;
  final String clinicName;
  final String startTime;
  final String status;

  @override
  List<Object?> get props => [
        id,
        patientId,
        patientName,
        patientCnic,
        mrNo,
        sessionTypes,
        consultantName,
        therapistName,
        clinicName,
        startTime,
        status,
      ];
}
