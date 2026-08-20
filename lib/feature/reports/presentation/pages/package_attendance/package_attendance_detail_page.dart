import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_pull_refresh.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/entities/package_attendance_detail_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/entities/package_attendance_detail_package_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/package_attendance_detail_bloc/package_attendance_detail_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_detail_header.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_detail_skeleton.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_purchased_package_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_session_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_summary_chip.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// PACKAGE ATTENDANCE DETAIL PAGE
// ------------------------------------------------------------
// GET /api/admin/reports/package-attendance/{patientId}
// ============================================================

class PackageAttendanceDetailPage extends StatelessWidget {
  const PackageAttendanceDetailPage({
    super.key,
    required this.patientId,
    required this.patientName,
    required this.mrNo,
    required this.phone,
  });

  final String patientId;
  final String patientName;
  final String mrNo;
  final String phone;

  bool _isLoading(PackageAttendanceDetailState state) {
    if (state is PackageAttendanceDetailLoading ||
        state is PackageAttendanceDetailInitial) {
      return true;
    }
    if (state is PackageAttendanceDetailLoaded) return state.isRefreshing;
    return false;
  }

  PackageAttendanceDetailEntity? _detailOf(
    PackageAttendanceDetailState state,
  ) {
    if (state is PackageAttendanceDetailLoaded) return state.detail;
    if (state is PackageAttendanceDetailError) return state.detail;
    return null;
  }

  String _selectedIdOf(PackageAttendanceDetailState state) {
    if (state is PackageAttendanceDetailLoaded) return state.selectedPackageId;
    if (state is PackageAttendanceDetailError) return state.selectedPackageId;
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PackageAttendanceDetailBloc>()
        ..add(PackageAttendanceDetailStarted(patientId)),
      child: BlocConsumer<PackageAttendanceDetailBloc,
          PackageAttendanceDetailState>(
        listener: (context, state) {
          if (state is PackageAttendanceDetailError) {
            AppSnackbar.error(context, state.message, title: state.title);
          }
        },
        builder: (context, state) {
          final isFirstLoad = state is PackageAttendanceDetailLoading ||
              state is PackageAttendanceDetailInitial;
          final detail = _detailOf(state);
          final selectedId = _selectedIdOf(state);
          final selectedPackage = detail?.packageById(selectedId);
          final headerName = detail?.patientName ?? patientName;
          final headerMrNo = detail?.mrNo ?? mrNo;
          final headerPhone = detail?.patientPhone ?? phone;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: FormBackAppBar(
              title: 'Package Attendance',
              isLoading: _isLoading(state),
            ),
            body: AppTabletSafeArea(
              child: AppPullRefresh(
                enabled: !isFirstLoad,
                onRefresh: () => context
                    .read<PackageAttendanceDetailBloc>()
                    .pullRefresh(),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: ClampingScrollPhysics(),
                  ),
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                  children: [
                    if (isFirstLoad)
                      const AppShimmer(
                        child: PackageAttendanceDetailSkeleton(),
                      )
                    else ...[
                      PackageAttendanceDetailHeader(
                        patientName: headerName,
                        mrNo: headerMrNo,
                        phone: headerPhone,
                      ),
                      SizedBox(height: 18.h),
                      Text(
                        'Purchased Packages',
                        style: AppTextStyles.heading3,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Tap a package to view its session attendance.',
                        style: AppTextStyles.bodySmall,
                      ),
                      SizedBox(height: 12.h),
                      if (detail == null || detail.packages.isEmpty)
                        Text(
                          'No packages found',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textMuted,
                          ),
                        )
                      else
                        for (var i = 0; i < detail.packages.length; i++) ...[
                          PackageAttendancePurchasedPackageCard(
                            packageName: detail.packages[i].packageName,
                            purchasedDate: detail.packages[i].purchasedDate,
                            attended: detail.packages[i].sessionsUsed,
                            totalSessions: detail.packages[i].sessionsTotal,
                            isActive: detail.packages[i].isActive,
                            isSelected:
                                detail.packages[i].id == selectedId,
                            onTap: () {
                              context
                                  .read<PackageAttendanceDetailBloc>()
                                  .add(
                                    PackageAttendanceDetailPackageSelected(
                                      detail.packages[i].id,
                                    ),
                                  );
                            },
                          ),
                          if (i != detail.packages.length - 1)
                            SizedBox(height: 10.h),
                        ],
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            size: AppSizes.iconMd,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'Attendance Timeline',
                              style: AppTextStyles.heading3,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Sessions for the selected package.',
                        style: AppTextStyles.bodySmall,
                      ),
                      SizedBox(height: 12.h),
                      _summaryChips(selectedPackage),
                      SizedBox(height: 16.h),
                      if (selectedPackage == null ||
                          selectedPackage.sessionsHistory.isEmpty)
                        Text(
                          'No attendance records found',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textMuted,
                          ),
                        )
                      else
                        for (var i = 0;
                            i < selectedPackage.sessionsHistory.length;
                            i++) ...[
                          PackageAttendanceSessionCard(
                            sessionNumber: selectedPackage
                                .sessionsHistory[i].sessionNumber,
                            date: selectedPackage.sessionsHistory[i].date,
                            therapist: selectedPackage
                                .sessionsHistory[i].therapistName,
                            clinic: selectedPackage
                                .sessionsHistory[i].clinicName,
                            timeDuration: selectedPackage
                                .sessionsHistory[i].timeDuration,
                            status:
                                selectedPackage.sessionsHistory[i].status,
                            notes: selectedPackage
                                    .sessionsHistory[i].hasNotes
                                ? selectedPackage.sessionsHistory[i].notes
                                : null,
                          ),
                          if (i !=
                              selectedPackage.sessionsHistory.length - 1)
                            SizedBox(height: 10.h),
                        ],
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _summaryChips(PackageAttendanceDetailPackageEntity? package) {
    final total = package?.sessionsTotal ?? 0;
    final attended = package?.sessionsUsed ?? 0;
    final remaining = package?.remaining ?? 0;

    return Row(
      children: [
        PackageAttendanceSummaryChip(
          label: 'Total',
          value: '$total',
          bg: AppColors.softGray,
          fg: AppColors.textPrimary,
        ),
        SizedBox(width: 8.w),
        PackageAttendanceSummaryChip(
          label: 'Attended',
          value: '$attended',
          bg: AppColors.successSoft,
          fg: AppColors.success,
        ),
        SizedBox(width: 8.w),
        PackageAttendanceSummaryChip(
          label: 'Remaining',
          value: '$remaining',
          bg: AppColors.warningSoft,
          fg: AppColors.warning,
        ),
      ],
    );
  }
}
