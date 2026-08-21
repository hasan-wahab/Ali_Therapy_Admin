import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/routes/route_names.dart';
import 'package:ali_therapy_admin/core/routes/app_page.dart';
import 'package:ali_therapy_admin/core/routes/auth_session_listenable.dart';
import 'package:ali_therapy_admin/core/services/auth_local_storage.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/active_packages/presentation/pages/active_packages/active_packages_page.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/pages/all_employees/all_employees_page.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/pages/edit_employee/edit_employee_page.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/pages/all_patients/all_patients_page.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/pages/change_password/change_password_page.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/pages/login/login_page.dart';
import 'package:ali_therapy_admin/feature/home/presentation/pages/home/home_page.dart';
import 'package:ali_therapy_admin/feature/patient/clinical_history/presentation/pages/clinical_history/clinical_history_page.dart';
import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/pages/consultant_details/consultant_details_page.dart';
import 'package:ali_therapy_admin/feature/patient/invoices/presentation/pages/invoices/invoices_page.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/pages/patient_detail/patient_detail_page.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/pages/patient_registration/patient_registration_page.dart';
import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/pages/add_document/add_document_page.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/pages/add_education/add_education_page.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/pages/add_experience/add_experience_page.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/pages/profile/profile_detail_page.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/pages/profile/profile_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/reports/reports_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/patient_dues/patient_dues_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/patient_dues/patient_dues_history_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/refer_by_report/refer_by_report_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/refer_by_report/referred_patients_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/insurance_panel_report/insurance_panel_report_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/patient_report/patient_report_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/consultation_report/consultation_report_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/reconsultation_report/reconsultation_report_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/free_consultation_report/free_consultation_report_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/therapist_report/therapist_report_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/assistant_manager_report/assistant_manager_report_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/receptionist_report/receptionist_report_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/user_activity_report/user_activity_report_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/package_attendance/package_attendance_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/package_attendance/package_attendance_detail_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/in_progress_sessions/in_progress_sessions_page.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/pages/discount_report/discount_report_page.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/addresses/addresses_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/audit/audit_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/bank_details/bank_details_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/biography/biography_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/documents/documents_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/education/education_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/emergency_contact/emergency_contact_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/employment_details/employment_details_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/experience/experience_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/personal_information/personal_information_section.dart';
import 'package:ali_therapy_admin/feature/patient/therapy_sessions/presentation/pages/therapy_sessions/therapy_sessions_page.dart';
import 'package:ali_therapy_admin/feature/patient/total_visits/presentation/pages/total_visits/total_visits_page.dart';

// ============================================================
// APP ROUTER (go_router)
// ============================================================

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    // Always start at login; [redirect] sends logged-in users to Home.
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    refreshListenable: AuthSessionListenable.instance,
    redirect: (context, state) {
      // Real session check (saved access_token).
      final hasSession = sl<AuthLocalStorage>().hasSessionSync();
      final location = state.matchedLocation;

      // Screens anyone can open without login.
      final isPublicAuthScreen = location == AppRoutes.login ||
          location == AppRoutes.forgotPassword ||
          location == AppRoutes.changePassword;

      // Not logged in → only login / forgot-password allowed.
      if (!hasSession && !isPublicAuthScreen) {
        return AppRoutes.login;
      }

      // Logged in → skip login screen, go to dashboard.
      if (hasSession && location == AppRoutes.login) {
        return AppRoutes.home;
      }

      // Stay on the requested screen.
      return null;
    },
    routes: [
          GoRoute(
            path: AppRoutes.login,
            name: 'login',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const LoginPage()),
          ),
          GoRoute(
            path: AppRoutes.forgotPassword,
            name: 'forgotPassword',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const ForgotPasswordPage()),
          ),
          GoRoute(
            path: AppRoutes.changePassword,
            name: 'changePassword',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const ChangePasswordPage()),
          ),
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const HomePage()),
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const ProfilePage()),
          ),
          GoRoute(
            path: AppRoutes.personalInfo,
            name: 'personalInfo',
            pageBuilder: (context, state) => AppPage.slide(
              state,
              _profileDetailFromExtra(
                state,
                title: 'Personal Information',
                sectionBuilder: (profile) =>
                    PersonalInformationSection(profile: profile),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.emergencyContact,
            name: 'emergencyContact',
            pageBuilder: (context, state) => AppPage.slide(
              state,
              _profileDetailFromExtra(
                state,
                title: 'Emergency Contact',
                sectionBuilder: (profile) =>
                    EmergencyContactSection(profile: profile),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.employmentDetails,
            name: 'employmentDetails',
            pageBuilder: (context, state) => AppPage.slide(
              state,
              _profileDetailFromExtra(
                state,
                title: 'Employment Details',
                sectionBuilder: (profile) =>
                    EmploymentDetailsSection(profile: profile),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.addresses,
            name: 'addresses',
            pageBuilder: (context, state) => AppPage.slide(
              state,
              _profileDetailFromExtra(
                state,
                title: 'Addresses',
                sectionBuilder: (profile) =>
                    AddressesSection(profile: profile),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.biography,
            name: 'biography',
            pageBuilder: (context, state) => AppPage.slide(
              state,
              _profileDetailFromExtra(
                state,
                title: 'Biography',
                sectionBuilder: (profile) =>
                    BiographySection(profile: profile),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.bankDetails,
            name: 'bankDetails',
            pageBuilder: (context, state) => AppPage.slide(
              state,
              _profileDetailFromExtra(
                state,
                title: 'Bank Details',
                sectionBuilder: (profile) =>
                    BankDetailsSection(profile: profile),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.documents,
            name: 'documents',
            pageBuilder: (context, state) => AppPage.slide(
              state,
              _profileDetailFromExtra(
                state,
                title: 'Documents',
                sectionBuilder: (profile) =>
                    DocumentsSection(profile: profile),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.education,
            name: 'education',
            pageBuilder: (context, state) => AppPage.slide(
              state,
              _profileDetailFromExtra(
                state,
                title: 'Education',
                sectionBuilder: (profile) =>
                    EducationSection(profile: profile),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.experience,
            name: 'experience',
            pageBuilder: (context, state) => AppPage.slide(
              state,
              _profileDetailFromExtra(
                state,
                title: 'Experience',
                sectionBuilder: (profile) =>
                    ExperienceSection(profile: profile),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.audit,
            name: 'audit',
            pageBuilder: (context, state) => AppPage.slide(
              state,
              _profileDetailFromExtra(
                state,
                title: 'Audit',
                sectionBuilder: (profile) => AuditSection(profile: profile),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.addDocument,
            name: 'addDocument',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const AddDocumentPage()),
          ),
          GoRoute(
            path: AppRoutes.addEducation,
            name: 'addEducation',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const AddEducationPage()),
          ),
          GoRoute(
            path: AppRoutes.addExperience,
            name: 'addExperience',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const AddExperiencePage()),
          ),
          GoRoute(
            path: AppRoutes.allEmployees,
            name: 'allEmployees',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const AllEmployeesPage()),
          ),
          GoRoute(
            path: AppRoutes.allPatients,
            name: 'allPatients',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const AllPatientsPage()),
          ),
          GoRoute(
            path: AppRoutes.patientRegistration,
            name: 'patientRegistration',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const PatientRegistrationPage()),
          ),
          GoRoute(
            path: AppRoutes.editPatient,
            name: 'editPatient',
            pageBuilder: (context, state) => AppPage.slide(
              state,
              const PatientRegistrationPage(isEdit: true),
            ),
          ),
          GoRoute(
            path: AppRoutes.patientDetail,
            name: 'patientDetail',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const PatientDetailPage()),
          ),
          GoRoute(
            path: AppRoutes.totalVisits,
            name: 'totalVisits',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const TotalVisitsPage()),
          ),
          GoRoute(
            path: AppRoutes.activePackages,
            name: 'activePackages',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const ActivePackagesPage()),
          ),
          GoRoute(
            path: AppRoutes.therapySessions,
            name: 'therapySessions',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const TherapySessionsPage()),
          ),
          GoRoute(
            path: AppRoutes.invoices,
            name: 'invoices',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const InvoicesPage()),
          ),
          GoRoute(
            path: AppRoutes.clinicalHistory,
            name: 'clinicalHistory',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const ClinicalHistoryPage()),
          ),
          GoRoute(
            path: AppRoutes.consultantDetails,
            name: 'consultantDetails',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const ConsultantDetailsPage()),
          ),
          GoRoute(
            path: AppRoutes.editEmployee,
            name: 'editEmployee',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const EditEmployeePage()),
          ),
          GoRoute(
            path: AppRoutes.reports,
            name: 'reports',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const ReportsPage()),
          ),
          GoRoute(
            path: AppRoutes.patientDues,
            name: 'patientDues',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const PatientDuesPage()),
          ),
          GoRoute(
            path: AppRoutes.patientDuesHistory,
            name: 'patientDuesHistory',
            pageBuilder: (context, state) {
              // GoRouter extra is often Map<String, dynamic> at runtime.
              final extra = _stringMapExtra(state.extra);
              return AppPage.slide(
                state,
                PatientDuesHistoryPage(
                  patientId: extra['patientId'] ?? '',
                  patientName: extra['patientName'] ?? 'Patient',
                  cnic: extra['cnic'] ?? '—',
                  phone: extra['phone'] ?? '—',
                ),
              );
            },
          ),
          GoRoute(
            path: AppRoutes.referByReport,
            name: 'referByReport',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const ReferByReportPage()),
          ),
          GoRoute(
            path: AppRoutes.referredPatients,
            name: 'referredPatients',
            pageBuilder: (context, state) {
              final extra = _dynamicMapExtra(state.extra);
              return AppPage.slide(
                state,
                ReferredPatientsPage(
                  referralSource:
                      extra['referralSource']?.toString() ?? 'Referral Source',
                  patientCount: (extra['patientCount'] as int?) ?? 0,
                ),
              );
            },
          ),
          GoRoute(
            path: AppRoutes.insurancePanelReport,
            name: 'insurancePanelReport',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const InsurancePanelReportPage()),
          ),
          GoRoute(
            path: AppRoutes.patientReport,
            name: 'patientReport',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const PatientReportPage()),
          ),
          GoRoute(
            path: AppRoutes.consultationReport,
            name: 'consultationReport',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const ConsultationReportPage()),
          ),
          GoRoute(
            path: AppRoutes.reconsultationReport,
            name: 'reconsultationReport',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const ReconsultationReportPage()),
          ),
          GoRoute(
            path: AppRoutes.freeConsultationReport,
            name: 'freeConsultationReport',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const FreeConsultationReportPage()),
          ),
          GoRoute(
            path: AppRoutes.therapistReport,
            name: 'therapistReport',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const TherapistReportPage()),
          ),
          GoRoute(
            path: AppRoutes.assistantManagerReport,
            name: 'assistantManagerReport',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const AssistantManagerReportPage()),
          ),
          GoRoute(
            path: AppRoutes.receptionistReport,
            name: 'receptionistReport',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const ReceptionistReportPage()),
          ),
          GoRoute(
            path: AppRoutes.userActivityReport,
            name: 'userActivityReport',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const UserActivityReportPage()),
          ),
          GoRoute(
            path: AppRoutes.packageAttendance,
            name: 'packageAttendance',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const PackageAttendancePage()),
          ),
          GoRoute(
            path: AppRoutes.packageAttendanceDetail,
            name: 'packageAttendanceDetail',
            pageBuilder: (context, state) {
              // GoRouter extra is often Map<String, dynamic> at runtime.
              final extra = _stringMapExtra(state.extra);
              return AppPage.slide(
                state,
                PackageAttendanceDetailPage(
                  patientId: extra['patientId'] ?? '',
                  patientName: extra['patientName'] ?? 'Patient',
                  mrNo: extra['mrNo'] ?? '_',
                  phone: extra['phone'] ?? '_',
                ),
              );
            },
          ),
          GoRoute(
            path: AppRoutes.inProgressSessions,
            name: 'inProgressSessions',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const InProgressSessionsPage()),
          ),
          GoRoute(
            path: AppRoutes.discountReport,
            name: 'discountReport',
            pageBuilder: (context, state) =>
                AppPage.slide(state, const DiscountReportPage()),
          ),
    ],
    errorBuilder: (context, state) =>
        _NotFoundPage(path: state.uri.toString()),
  );
}

/// Safe cast for GoRouter `extra` maps (runtime type is often Map<String, dynamic>).
Map<String, String> _stringMapExtra(Object? extra) {
  if (extra is Map<String, String>) return extra;
  if (extra is Map) {
    return {
      for (final entry in extra.entries)
        entry.key.toString(): entry.value?.toString() ?? '',
    };
  }
  return {};
}

Map<String, dynamic> _dynamicMapExtra(Object? extra) {
  if (extra is Map<String, dynamic>) return extra;
  if (extra is Map) {
    return Map<String, dynamic>.from(extra);
  }
  return {};
}

/// Builds a profile section page from View's ProfileEntity (no API).
Widget _profileDetailFromExtra(
  GoRouterState state, {
  required String title,
  required Widget Function(ProfileEntity profile) sectionBuilder,
}) {
  final extra = state.extra;
  if (extra is! ProfileEntity) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBackAppBar(title: title),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Open this section from Profile after View.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
          ),
        ),
      ),
    );
  }

  return ProfileDetailPage(
    title: title,
    profile: extra,
    child: sectionBuilder(extra),
  );
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBackAppBar(title: 'Page not found'),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.link_off,
                  size: AppSizes.iconXl,
                  color: AppColors.textMuted,
                ),
                SizedBox(height: 16.h),
                Text('Page not found', style: AppTextStyles.heading3),
                SizedBox(height: 8.h),
                Text(
                  path,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall,
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () => context.go(AppRoutes.login),
                  child: const Text('Go to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
