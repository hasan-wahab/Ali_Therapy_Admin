import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/utils/app_permission.dart';

// ============================================================
// REPORT TYPE
// ------------------------------------------------------------
// All report shortcuts shown in the Reports sheet grid.
// ============================================================

enum ReportType {
  patientDues,
  patientReport,
  referByReport,
  insurancePanelReport,
  packageAttendance,
  consultationReport,
  reconsultationReport,
  freeConsultationReport,
  inProgressSessions,
  therapistReport,
  assistantManagerReport,
  receptionistReport,
  userActivityReport,
  discountReport,
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
      case ReportType.inProgressSessions:
        return 'In-Progress Sessions';
      case ReportType.discountReport:
        return 'Discount Report';
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
      case ReportType.inProgressSessions:
        return Icons.pending_actions_outlined;
      case ReportType.discountReport:
        return Icons.local_offer_outlined;
    }
  }

  bool get isPermitted {
    switch (this) {
      case ReportType.patientDues:
        return AppPermission.canViewPatientDuesReport;
      case ReportType.referByReport:
        return AppPermission.canViewReferByReport;
      case ReportType.insurancePanelReport:
        return AppPermission.canViewInsurancePanelReport;
      case ReportType.patientReport:
        return AppPermission.canViewPatientReport;
      case ReportType.consultationReport:
        return AppPermission.canViewConsultantReport;
      case ReportType.reconsultationReport:
        return AppPermission.canViewUnnamedReport;
      case ReportType.freeConsultationReport:
        return AppPermission.canViewUnnamedReport;
      case ReportType.therapistReport:
        return AppPermission.canViewTherapistReport;
      case ReportType.assistantManagerReport:
        return AppPermission.canViewAssistantManagerReport;
      case ReportType.receptionistReport:
        return AppPermission.canViewReceptionistReport;
      case ReportType.userActivityReport:
        return AppPermission.canViewUserActivityReport;
      case ReportType.packageAttendance:
        return AppPermission.canViewUnnamedReport;
      case ReportType.inProgressSessions:
        return AppPermission.canViewUnnamedReport;
      case ReportType.discountReport:
        return AppPermission.canViewUnnamedReport;
    }
  }
}
