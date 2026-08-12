import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:ali_therapy_admin/core/routes/route_names.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_type.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/reports_grid.dart';

// ============================================================
// REPORTS PAGE
// ------------------------------------------------------------
// Reports hub screen (replaces the old bottom sheet).
// ============================================================

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  String? _routeFor(ReportType type) {
    switch (type) {
      case ReportType.patientDues:
        return AppRoutes.patientDues;
      case ReportType.referByReport:
        return AppRoutes.referByReport;
      case ReportType.insurancePanelReport:
        return AppRoutes.insurancePanelReport;
      case ReportType.patientReport:
        return AppRoutes.patientReport;
      case ReportType.consultationReport:
        return AppRoutes.consultationReport;
      case ReportType.reconsultationReport:
        return AppRoutes.reconsultationReport;
      case ReportType.freeConsultationReport:
        return AppRoutes.freeConsultationReport;
      case ReportType.therapistReport:
        return AppRoutes.therapistReport;
      case ReportType.assistantManagerReport:
        return AppRoutes.assistantManagerReport;
      case ReportType.receptionistReport:
        return AppRoutes.receptionistReport;
      case ReportType.userActivityReport:
        return AppRoutes.userActivityReport;
      case ReportType.packageAttendance:
        return AppRoutes.packageAttendance;
    }
  }

  void _onReportSelected(BuildContext context, ReportType type) {
    final path = _routeFor(type);

    if (path == null) {
      AppSnackbar.info(context, '${type.title} coming soon');
      return;
    }

    GoRouter.of(context).push(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Reports'),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
          children: [
            ReportsGrid(
              onReportSelected: (type) => _onReportSelected(context, type),
            ),
          ],
        ),
      ),
    );
  }
}
