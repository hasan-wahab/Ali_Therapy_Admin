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
