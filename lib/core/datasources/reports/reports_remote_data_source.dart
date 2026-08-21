import 'package:ali_therapy_admin/feature/reports/data/assistant_manager_report_data/models/assistant_manager_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/consultation_report_data/models/consultation_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/free_consultation_report_data/models/free_consultation_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/patient_dues_data/models/patient_dues_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/patient_dues_history_data/models/patient_dues_history_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/package_attendance_data/models/package_attendance_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/package_attendance_detail_data/models/package_attendance_detail_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/patient_report_data/models/patient_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/reconsultation_report_data/models/reconsultation_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/discount_report_data/models/discount_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/in_progress_sessions_data/models/in_progress_sessions_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/insurance_panel_report_data/models/insurance_panel_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/refer_by_report_data/models/refer_by_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/report_filter_options_data/models/report_filter_options_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/receptionist_report_data/models/receptionist_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/therapist_report_data/models/therapist_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/user_activity_report_data/models/user_activity_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/consultation_report_domain/entities/consultation_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/free_consultation_report_domain/entities/free_consultation_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/entities/patient_dues_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/entities/package_attendance_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/entities/patient_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/entities/reconsultation_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/entities/refer_by_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/entities/receptionist_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/entities/therapist_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/entities/user_activity_report_query.dart';

// ============================================================
// REPORTS REMOTE DATA SOURCE (contract)
// ------------------------------------------------------------
// Lives in core/datasources/reports/
// Talks to the API. Throws AppException on errors.
// ============================================================

abstract class ReportsRemoteDataSource {
  /// GET /api/admin/reports/filter-options
  Future<ReportFilterOptionsModel> getFilterOptions();

  /// GET /api/admin/reports/patient-dues
  Future<PatientDuesPageModel> getPatientDuesPage({
    required PatientDuesQuery query,
  });

  /// GET /api/admin/reports/patient-dues/{patientId}
  Future<List<PatientDuesHistoryModel>> getPatientDuesHistory({
    required String patientId,
  });

  /// GET /api/admin/reports/consultant
  Future<ConsultationReportPageModel> getConsultationReportPage({
    required ConsultationReportQuery query,
  });

  /// GET /api/admin/reports/therapist
  Future<TherapistReportPageModel> getTherapistReportPage({
    required TherapistReportQuery query,
  });

  /// GET /api/admin/reports/reconsultation
  Future<ReconsultationReportPageModel> getReconsultationReportPage({
    required ReconsultationReportQuery query,
  });

  /// GET /api/admin/reports/free-consultation
  Future<FreeConsultationReportPageModel> getFreeConsultationReportPage({
    required FreeConsultationReportQuery query,
  });

  /// GET /api/admin/reports/assistant-manager
  Future<AssistantManagerReportPageModel> getAssistantManagerReportPage({
    required AssistantManagerReportQuery query,
  });

  /// GET /api/admin/reports/receptionist
  Future<ReceptionistReportPageModel> getReceptionistReportPage({
    required ReceptionistReportQuery query,
  });

  /// GET /api/admin/reports/patient-report
  Future<PatientReportPageModel> getPatientReportPage({
    required PatientReportQuery query,
  });

  /// GET /api/admin/reports/package-attendance
  Future<PackageAttendancePageModel> getPackageAttendancePage({
    required PackageAttendanceQuery query,
  });

  /// GET /api/admin/reports/package-attendance/{patientId}
  Future<PackageAttendanceDetailModel> getPackageAttendanceDetail({
    required String patientId,
  });

  /// GET /api/admin/reports/refer-by
  Future<List<ReferByReportModel>> getReferByReport({
    required ReferByReportQuery query,
  });

  /// GET /api/admin/reports/insurance-panel
  Future<InsurancePanelReportResultModel> getInsurancePanelReport({
    required InsurancePanelReportQuery query,
  });

  /// GET /api/admin/reports/in-progress-sessions
  Future<InProgressSessionsPageModel> getInProgressSessionsPage({
    required InProgressSessionsQuery query,
  });

  /// GET /api/admin/reports/discount
  Future<DiscountReportPageModel> getDiscountReportPage({
    required DiscountReportQuery query,
  });

  /// GET /api/admin/reports/user-activity
  Future<UserActivityReportPageModel> getUserActivityReportPage({
    required UserActivityReportQuery query,
  });
}
