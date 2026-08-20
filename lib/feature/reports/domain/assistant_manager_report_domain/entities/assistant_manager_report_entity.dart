import 'package:equatable/equatable.dart';

// ============================================================
// ASSISTANT MANAGER REPORT ENTITY (Domain)
// ------------------------------------------------------------
// One row from GET /api/admin/reports/assistant-manager
// ============================================================

class AssistantManagerReportEntity extends Equatable {
  const AssistantManagerReportEntity({
    required this.id,
    required this.visitDate,
    required this.patientName,
    required this.patientPhone,
    required this.patientCnic,
    required this.assistantManagerName,
    required this.consultantName,
    required this.clinicName,
    required this.stage,
  });

  final String id;
  final String visitDate;
  final String patientName;
  final String patientPhone;
  final String patientCnic;
  final String assistantManagerName;
  final String consultantName;
  final String clinicName;
  final String stage;

  bool get isCompleted => stage.toLowerCase() == 'completed';

  @override
  List<Object?> get props => [
        id,
        visitDate,
        patientName,
        patientPhone,
        patientCnic,
        assistantManagerName,
        consultantName,
        clinicName,
        stage,
      ];
}
