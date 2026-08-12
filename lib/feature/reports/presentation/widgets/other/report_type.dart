import 'package:flutter/material.dart';

// ============================================================
// REPORT TYPE
// ------------------------------------------------------------
// All report shortcuts shown in the Reports sheet grid.
// ============================================================

enum ReportType {
  patientDues,
  referByReport,
  insurancePanelReport,
  patientReport,
  packageAttendance,
  consultationReport,
  reconsultationReport,
  freeConsultationReport,
  therapistReport,
  assistantManagerReport,
  receptionistReport,
  userActivityReport,
}

extension ReportTypeUi on ReportType {
  String get title {
    switch (this) {
      case ReportType.patientDues:
        return 'Patient Dues';
      case ReportType.referByReport:
        return 'Refer By Report';
      case ReportType.insurancePanelReport:
        return 'Insurance Panel Report';
      case ReportType.patientReport:
        return 'Patient Report';
      case ReportType.packageAttendance:
        return 'Package Attendance';
      case ReportType.consultationReport:
        return 'Consultation Report';
      case ReportType.reconsultationReport:
        return 'Reconsultation Report';
      case ReportType.freeConsultationReport:
        return 'Free Consultation Report';
      case ReportType.therapistReport:
        return 'Therapist Report';
      case ReportType.assistantManagerReport:
        return 'Assistant Manager Report';
      case ReportType.receptionistReport:
        return 'Receptionist Report';
      case ReportType.userActivityReport:
        return 'User Activity Report';
    }
  }

  IconData get icon {
    switch (this) {
      case ReportType.patientDues:
        return Icons.account_balance_wallet_outlined;
      case ReportType.referByReport:
        return Icons.share_outlined;
      case ReportType.insurancePanelReport:
        return Icons.health_and_safety_outlined;
      case ReportType.patientReport:
        return Icons.personal_injury_outlined;
      case ReportType.packageAttendance:
        return Icons.event_available_outlined;
      case ReportType.consultationReport:
        return Icons.medical_services_outlined;
      case ReportType.reconsultationReport:
        return Icons.history_rounded;
      case ReportType.freeConsultationReport:
        return Icons.volunteer_activism_outlined;
      case ReportType.therapistReport:
        return Icons.handshake_outlined;
      case ReportType.assistantManagerReport:
        return Icons.badge_outlined;
      case ReportType.receptionistReport:
        return Icons.support_agent_outlined;
      case ReportType.userActivityReport:
        return Icons.manage_accounts_outlined;
    }
  }
}
