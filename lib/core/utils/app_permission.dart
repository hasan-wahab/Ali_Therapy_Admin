import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/routes/route_names.dart';
import 'package:ali_therapy_admin/core/services/auth_local_storage.dart';

// ============================================================
// APP PERMISSION
// ------------------------------------------------------------
// Checks login "permissions" from the saved session.
// Names match the API strings (normalized: trim + lower case).
// UI and routes use this — never hardcode role names.
// ============================================================

class AppPermission {
  AppPermission._();

  static String _normalize(String value) {
    return value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }

  static Set<String> _savedNames() {
    final login = sl<AuthLocalStorage>().getSavedLoginSync();
    if (login == null) return const {};
    return {
      for (final item in login.permissions)
        if (item.name.trim().isNotEmpty && item.name != '_')
          _normalize(item.name),
    };
  }

  /// True if the logged-in user has this exact API permission.
  static bool has(String permission) {
    if (permission.trim().isEmpty) return false;
    return _savedNames().contains(_normalize(permission));
  }

  /// True if the user has at least one of these permissions.
  static bool hasAny(List<String> permissions) {
    if (permissions.isEmpty) return false;
    final saved = _savedNames();
    for (final permission in permissions) {
      if (saved.contains(_normalize(permission))) return true;
    }
    return false;
  }

  // ----------------------------------------------------------
  // Employees
  // ----------------------------------------------------------

  static bool get canViewEmployees => hasAny(const [
    'view all employees',
    'view employees',
    'view employee',
    'view own employee',
    'view user management',
  ]);

  static bool get canAddEmployee => has('add employee');

  static bool get canEditEmployee =>
      hasAny(const ['edit employee', 'update employee']);

  static bool get canDeleteEmployee => has('delete employee');

  static bool get canChangeEmployeePassword => has('update password employee');

  /// Terminate / device / biometric / status — no dedicated API keys.
  static bool get canManageEmployee => canEditEmployee;

  static bool get canViewEmployeeProfile => canViewEmployees;

  static bool get canViewEducation => has('view education');

  static bool get canEditEducation => hasAny(const [
    'updateorcreate education',
    'edit education',
    'update education',
  ]);

  static bool get canUpdatePicture => has('update pciture');

  static bool get canUpdateOwnPassword => has('update password');

  // ----------------------------------------------------------
  // Patients
  // ----------------------------------------------------------

  static bool get canViewPatients => hasAny(const [
    'view patient',
    'view own patient',
    'management view patients',
  ]);

  static bool get canAddPatient =>
      hasAny(const ['add patient', 'add patient card']);

  static bool get canEditPatient =>
      hasAny(const ['edit patient', 'update patient']);

  static bool get canDeletePatient => has('delete patient');

  static bool get canViewSurvey =>
      hasAny(const ['view survey questions', 'view survey responses']);

  // ----------------------------------------------------------
  // Reports
  // ----------------------------------------------------------

  static bool get canViewReportsHub => has('view report') || _hasAnyNamedReport;

  static bool get _hasAnyNamedReport => hasAny(const [
    'view patient dues report',
    'view patient refer by report',
    'view patient insurance panel report',
    'view insurance panel',
    'view patient report',
    'view consultant report',
    'view therapist report',
    'view assistant manager report',
    'view receptionist report',
    'view user activity report',
  ]);

  static bool get canViewPatientDuesReport => has('view patient dues report');

  static bool get canViewReferByReport => has('view patient refer by report');

  static bool get canViewInsurancePanelReport => hasAny(const [
    'view patient insurance panel report',
    'view insurance panel',
  ]);

  static bool get canViewPatientReport => has('view patient report');

  static bool get canViewConsultantReport => has('view consultant report');

  static bool get canViewTherapistReport => has('view therapist report');

  static bool get canViewAssistantManagerReport =>
      has('view assistant manager report');

  static bool get canViewReceptionistReport => has('view receptionist report');

  static bool get canViewUserActivityReport => has('view user activity report');

  /// Reports with no dedicated API key yet.
  static bool get canViewUnnamedReport => has('view report');

  // ----------------------------------------------------------
  // Dashboard
  // ----------------------------------------------------------

  static bool get canViewFinance => has('view finance menu');

  static bool get canViewDashboardOverview =>
      canViewEmployees ||
      canViewPatients ||
      canViewFinance ||
      canViewReportsHub;

  static bool get canViewQuickAccess =>
      canViewEmployees || canViewPatients || canViewReportsHub;

  // ----------------------------------------------------------
  // Routes (deep-link / URL guard)
  // ----------------------------------------------------------

  static bool canOpenRoute(String location) {
    if (location == AppRoutes.home ||
        location == AppRoutes.login ||
        location == AppRoutes.forgotPassword ||
        location == AppRoutes.changePassword) {
      return true;
    }

    if (location == AppRoutes.allEmployees) return canViewEmployees;
    if (location == AppRoutes.editEmployee) return canEditEmployee;

    if (location == AppRoutes.addEducation) return canEditEducation;
    if (location == AppRoutes.addDocument ||
        location == AppRoutes.addExperience) {
      return canEditEmployee;
    }
    if (location == AppRoutes.profile || location.startsWith('/profile')) {
      return canViewEmployeeProfile;
    }

    if (location == AppRoutes.allPatients) return canViewPatients;
    if (location == AppRoutes.patientRegistration) return canAddPatient;
    if (location == AppRoutes.editPatient) return canEditPatient;
    if (location == AppRoutes.patientDetail ||
        location == AppRoutes.totalVisits ||
        location == AppRoutes.activePackages ||
        location == AppRoutes.therapySessions ||
        location == AppRoutes.invoices ||
        location == AppRoutes.clinicalHistory ||
        location == AppRoutes.consultantDetails ||
        location == AppRoutes.reconsultationHistory ||
        location == AppRoutes.reconsultationHistoryReport ||
        location == AppRoutes.nfcCard) {
      return canViewPatients;
    }

    if (location == AppRoutes.reports) return canViewReportsHub;
    if (location == AppRoutes.patientDues ||
        location == AppRoutes.patientDuesHistory) {
      return canViewPatientDuesReport;
    }
    if (location == AppRoutes.referByReport ||
        location == AppRoutes.referredPatients) {
      return canViewReferByReport;
    }
    if (location == AppRoutes.insurancePanelReport) {
      return canViewInsurancePanelReport;
    }
    if (location == AppRoutes.patientReport) return canViewPatientReport;
    if (location == AppRoutes.consultationReport) {
      return canViewConsultantReport;
    }
    if (location == AppRoutes.therapistReport) return canViewTherapistReport;
    if (location == AppRoutes.assistantManagerReport) {
      return canViewAssistantManagerReport;
    }
    if (location == AppRoutes.receptionistReport) {
      return canViewReceptionistReport;
    }
    if (location == AppRoutes.userActivityReport) {
      return canViewUserActivityReport;
    }
    if (location == AppRoutes.reconsultationReport ||
        location == AppRoutes.freeConsultationReport ||
        location == AppRoutes.packageAttendance ||
        location == AppRoutes.packageAttendanceDetail ||
        location == AppRoutes.inProgressSessions ||
        location == AppRoutes.discountReport) {
      return canViewUnnamedReport;
    }

    return true;
  }
}
