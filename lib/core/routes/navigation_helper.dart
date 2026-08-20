import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ali_therapy_admin/core/routes/route_names.dart';
import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';

// ============================================================
// NAVIGATION HELPER
// ------------------------------------------------------------
// Short helper methods for beginners.
// Navigation only — no UseCase / Repository calls here.
// ============================================================

class AppNavigation {
  AppNavigation._();

  static void goLogin(BuildContext context) {
    context.go(AppRoutes.login);
  }

  // Logout business logic lives in AuthBloc (AuthLogoutRequested).
  // UI must NOT call LogoutUseCase here — only navigate after AuthUnauthenticated.

  static void openForgotPassword(BuildContext context) {
    context.push(AppRoutes.forgotPassword);
  }

  static void openChangePassword(BuildContext context) {
    context.push(AppRoutes.changePassword);
  }

  /// Dashboard shortcut — profile View needs an employee id from the list.
  static void goProfile(BuildContext context) {
    context.go(AppRoutes.profile);
  }

  /// All Employees → View: open hub and load GET employees/{employeeId}.
  static void openProfile(
    BuildContext context, {
    required String employeeId,
  }) {
    context.push(AppRoutes.profile, extra: employeeId);
  }

  static void goHome(BuildContext context) {
    context.go(AppRoutes.home);
  }

  static void openHome(BuildContext context) {
    context.push(AppRoutes.home);
  }

  /// Open a profile section — reuses View data (no second API call).
  static void openProfileSection(
    BuildContext context,
    String route, {
    required ProfileEntity profile,
  }) {
    context.push(route, extra: profile);
  }

  static void openAddDocument(BuildContext context) {
    context.push(AppRoutes.addDocument);
  }

  static void openAddEducation(BuildContext context) {
    context.push(AppRoutes.addEducation);
  }

  static void openAddExperience(BuildContext context) {
    context.push(AppRoutes.addExperience);
  }

  static void openAllEmployees(BuildContext context) {
    context.push(AppRoutes.allEmployees);
  }

  static void openAllPatients(BuildContext context) {
    context.push(AppRoutes.allPatients);
  }

  static void openPatientRegistration(BuildContext context) {
    context.push(AppRoutes.patientRegistration);
  }

  static void openEditPatient(BuildContext context) {
    context.push(AppRoutes.editPatient);
  }

  /// Open patient Detail screen.
  static void openPatientDetail(BuildContext context) {
    context.push(AppRoutes.patientDetail);
  }

  static void openTotalVisits(BuildContext context) {
    context.push(AppRoutes.totalVisits);
  }

  static void openActivePackages(BuildContext context) {
    context.push(AppRoutes.activePackages);
  }

  static void openTherapySessions(BuildContext context) {
    context.push(AppRoutes.therapySessions);
  }

  static void openInvoices(BuildContext context) {
    context.push(AppRoutes.invoices);
  }

  static void openClinicalHistory(BuildContext context) {
    context.push(AppRoutes.clinicalHistory);
  }

  static void openConsultantDetails(BuildContext context) {
    context.push(AppRoutes.consultantDetails);
  }

  static void openEditEmployee(BuildContext context) {
    context.push(AppRoutes.editEmployee);
  }

  static void openPatientDues(BuildContext context) {
    context.push(AppRoutes.patientDues);
  }

  static void openReports(BuildContext context) {
    context.push(AppRoutes.reports);
  }

  static void openPatientDuesHistory(
    BuildContext context, {
    required String patientId,
    required String patientName,
    required String cnic,
    required String phone,
  }) {
    context.push(
      AppRoutes.patientDuesHistory,
      extra: <String, String>{
        'patientId': patientId,
        'patientName': patientName,
        'cnic': cnic,
        'phone': phone,
      },
    );
  }

  static void openReferByReport(BuildContext context) {
    context.push(AppRoutes.referByReport);
  }

  static void openReferredPatients(
    BuildContext context, {
    required String referralSource,
    required int patientCount,
  }) {
    context.push(
      AppRoutes.referredPatients,
      extra: <String, Object>{
        'referralSource': referralSource,
        'patientCount': patientCount,
      },
    );
  }

  static void openInsurancePanelReport(BuildContext context) {
    context.push(AppRoutes.insurancePanelReport);
  }

  static void openPatientReport(BuildContext context) {
    context.push(AppRoutes.patientReport);
  }

  static void openConsultationReport(BuildContext context) {
    context.push(AppRoutes.consultationReport);
  }

  static void openReconsultationReport(BuildContext context) {
    context.push(AppRoutes.reconsultationReport);
  }

  static void openFreeConsultationReport(BuildContext context) {
    context.push(AppRoutes.freeConsultationReport);
  }

  static void openTherapistReport(BuildContext context) {
    context.push(AppRoutes.therapistReport);
  }

  static void openAssistantManagerReport(BuildContext context) {
    context.push(AppRoutes.assistantManagerReport);
  }

  static void openReceptionistReport(BuildContext context) {
    context.push(AppRoutes.receptionistReport);
  }

  static void openUserActivityReport(BuildContext context) {
    context.push(AppRoutes.userActivityReport);
  }

  static void openPackageAttendance(BuildContext context) {
    context.push(AppRoutes.packageAttendance);
  }

  static void openPackageAttendanceDetail(
    BuildContext context, {
    required String patientId,
    required String patientName,
    required String mrNo,
    required String phone,
  }) {
    context.push(
      AppRoutes.packageAttendanceDetail,
      extra: <String, String>{
        'patientId': patientId,
        'patientName': patientName,
        'mrNo': mrNo,
        'phone': phone,
      },
    );
  }

  static void back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.login);
    }
  }
}
