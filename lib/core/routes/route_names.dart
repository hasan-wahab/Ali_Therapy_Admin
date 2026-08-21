// ============================================================
// ROUTE NAMES
// ------------------------------------------------------------
// Keep every screen path in this one file.
// Always use AppRoutes.* — never hardcode path strings.
// ============================================================

class AppRoutes {
  AppRoutes._();

  static const String login = '/';
  static const String forgotPassword = '/forgot-password';
  static const String changePassword = '/change-password';
  static const String home = '/home';
  static const String profile = '/profile';

  // Profile section detail screens
  static const String personalInfo = '/profile/personal-info';
  static const String emergencyContact = '/profile/emergency-contact';
  static const String employmentDetails = '/profile/employment-details';
  static const String addresses = '/profile/addresses';
  static const String biography = '/profile/biography';
  static const String bankDetails = '/profile/bank-details';
  static const String documents = '/profile/documents';
  static const String education = '/profile/education';
  static const String experience = '/profile/experience';
  static const String audit = '/profile/audit';

  // Add form screens (UI only for now)
  static const String addDocument = '/profile/documents/add';
  static const String addEducation = '/profile/education/add';
  static const String addExperience = '/profile/experience/add';

  // All Employees
  static const String allEmployees = '/all-employees';

  // All Patients
  static const String allPatients = '/all-patients';

  // Patient Registration
  static const String patientRegistration = '/patient-registration';

  // Edit Patient (same forms as registration)
  static const String editPatient = '/edit-patient';

  // Patient Detail
  static const String patientDetail = '/patient-detail';

  // Patient metric features
  static const String totalVisits = '/total-visits';
  static const String activePackages = '/active-packages';
  static const String therapySessions = '/therapy-sessions';
  static const String invoices = '/invoices';
  static const String clinicalHistory = '/clinical-history';
  static const String consultantDetails = '/consultant-details';

  // Edit Employee
  static const String editEmployee = '/edit-employee';

  // Reports
  static const String reports = '/reports';
  static const String patientDues = '/reports/patient-dues';
  static const String patientDuesHistory = '/reports/patient-dues/history';
  static const String referByReport = '/reports/refer-by';
  static const String referredPatients = '/reports/refer-by/patients';
  static const String insurancePanelReport = '/reports/insurance-panel';
  static const String patientReport = '/reports/patient-report';
  static const String consultationReport = '/reports/consultation-report';
  static const String reconsultationReport = '/reports/reconsultation-report';
  static const String freeConsultationReport = '/reports/free-consultation-report';
  static const String therapistReport = '/reports/therapist-report';
  static const String assistantManagerReport = '/reports/assistant-manager-report';
  static const String receptionistReport = '/reports/receptionist-report';
  static const String userActivityReport = '/reports/user-activity-report';
  static const String packageAttendance = '/reports/package-attendance';
  static const String packageAttendanceDetail =
      '/reports/package-attendance/detail';
  static const String inProgressSessions = '/reports/in-progress-sessions';
  static const String discountReport = '/reports/discount-report';
}
