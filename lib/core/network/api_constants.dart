// ============================================================
// API CONSTANTS
// ------------------------------------------------------------
// Keep all API URLs and endpoint paths in ONE place.
// If the backend URL changes, you only edit this file.
// ============================================================

class ApiConstants {
  ApiConstants._(); // private constructor → cannot create objects

  // ----------------------------------------------------------
  // BASE URL
  // Change this when you switch between staging / production.
  // ----------------------------------------------------------
  static const String baseUrl = 'https://alitherapy.neonweb.tech/api/admin/';
  // // old for testing
  // static String imageBaseUrl = 'https://alitherapy.neonweb.tech';
  //static const String baseUrl = 'https://example.com/api/';

  // ----------------------------------------------------------
  // TIMEOUTS (how long we wait for the server)
  // ----------------------------------------------------------
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // ----------------------------------------------------------
  // COMMON HEADERS
  // ----------------------------------------------------------
  static const String contentType = 'application/json';
  static const String accept = 'application/json';

  // Header key where we send the login token.
  static const String authorizationHeader = 'Authorization';

  // ----------------------------------------------------------
  // AUTH ENDPOINTS
  // ----------------------------------------------------------
  static const String login = 'login';
  static const String logout = 'logout';
  // Laravel: Route::post('admin/forgot-password', ...)
  // Full URL = baseUrl + this → .../api/admin/forgot-password
  static const String forgetPassword = 'forgot-password';
  // Laravel: typically Route::post('admin/change-password', ...)
  // Full URL = baseUrl + this → .../api/admin/change-password
  static const String changePassword = 'change-password';
  static const String uploadProfile = 'profile-picture';
  static const String updateProfile = 'update-profile';

  // ----------------------------------------------------------
  // PATIENT ENDPOINTS
  // ----------------------------------------------------------
  /// GET — list all patients
  static const String patients = 'patients';

  /// GET — show one patient
  static String patientDetails(String id) => 'patient/$id';

  /// GET —  Search patients
  static const String searchPatients = 'search-patients';

  // ----------------------------------------------------------
  // EMPLOYEE ENDPOINTS
  // Matches Laravel EmployeesApiController routes
  // ----------------------------------------------------------
  /// GET — list all employees
  static const String employeesList = 'employees-list';

  /// GET — All Employees filter dropdown data
  /// (roles, designations, clinics, departments, shifts, statuses)
  static const String employeesFiltersData = 'employees-filters-data';

  /// GET — show one employee
  static String employeeShow(String id) => 'employees/$id';

  /// GET — edit form / employee data for edit
  static String employeeEdit(String id) => 'employees/$id/edit';

  /// POST — create employee
  static const String employeeStore = 'employees/store';

  /// POST — update employee
  static String employeeUpdate(String id) => 'employees/update/$id';

  /// DELETE — delete employee
  static String employeeDelete(String id) => 'employees/$id';

  /// POST — toggle employee active / inactive status
  static String employeeToggleStatus(String id) =>
      'employees/$id/toggle-status';

  /// POST — terminate employee
  static String employeeTerminate(String id) => 'employees/$id/terminate';

  /// POST — change employee password
  static String employeeChangePassword(String id) =>
      'employees/$id/change-password';

  /// POST — assign device ID to employee
  static String employeeAssignDeviceId(String id) =>
      'employees/$id/assign-device-id';

  /// POST — assign biometric ID to employee
  static String employeeAssignBiometricId(String id) =>
      'employees/$id/assign-biometric-id';

  // ----------------------------------------------------------
  // REPORTS ENDPOINTS
  // Base: /api/admin/reports/...
  // ----------------------------------------------------------
  /// Prefix for every report endpoint.
  /// Usage: ApiConstants.reports('patient-dues')
  static String reports(String path) => 'reports/$path';

  /// GET — all filter dropdowns for report screens
  /// (clinics, consultants, therapists, receptionists,
  ///  assistant_managers, insurance_panels)
  static const String reportsFilterOptions = 'reports/filter-options';

  /// GET — paginated patient dues list
  static const String patientDues = 'reports/patient-dues';

  /// GET — invoice history for one patient
  static String patientDuesHistory(String patientId) =>
      'reports/patient-dues/$patientId';

  /// GET — paginated consultant / consultation report list
  static const String consultationReport = 'reports/consultant';

  /// GET — paginated therapist report list
  static const String therapistReport = 'reports/therapist';

  /// GET — paginated reconsultation report list
  static const String reconsultationReport = 'reports/reconsultation';

  /// GET — paginated free consultation report list
  static const String freeConsultationReport = 'reports/free-consultation';

  /// GET — paginated assistant manager report list
  static const String assistantManagerReport = 'reports/assistant-manager';

  /// GET — paginated receptionist report list
  static const String receptionistReport = 'reports/receptionist';

  /// GET — paginated patient report list
  static const String patientReport = 'reports/patient-report';

  /// GET — paginated package attendance list
  static const String packageAttendance = 'reports/package-attendance';

  /// GET — packages + session history for one patient
  static String packageAttendanceDetail(String patientId) =>
      'reports/package-attendance/$patientId';

  /// GET — refer-by report list
  static const String referByReport = 'reports/refer-by';

  /// GET — insurance panel report list + summary
  static const String insurancePanelReport = 'reports/insurance-panel';

  /// GET — paginated user activity report list
  static const String userActivityReport = 'reports/user-activity';

  // ----------------------------------------------------------
  // ATTENDANCE ENDPOINTS
  // Matches Laravel AttendancesApiController routes
  // ----------------------------------------------------------
  /// Resource base: index / store / show / update / destroy
  static const String attendances = 'apiattendances';

  /// GET — list attendances
  static const String attendancesList = 'apiattendances';

  /// POST — create attendance
  static const String attendanceStore = 'apiattendances';

  /// GET — show one attendance
  static String attendanceShow(String id) => 'apiattendances/$id';

  /// PUT/PATCH — update attendance
  static String attendanceUpdate(String id) => 'apiattendances/$id';

  /// DELETE — delete attendance
  static String attendanceDestroy(String id) => 'apiattendances/$id';

  /// POST — bulk store attendances
  static const String attendancesBulk = 'apiattendances/bulk';

  /// POST — import attendances
  static const String attendancesImport = 'apiattendances/import';

  /// GET — export attendances
  static const String attendancesExport = 'apiattendances/export';
}
