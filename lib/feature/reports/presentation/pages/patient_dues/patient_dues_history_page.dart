import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_pull_refresh.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/patient_dues_history_bloc/patient_dues_history_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_history_header.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_history_table.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_history_table_skeleton.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// PATIENT DUES HISTORY PAGE
// ------------------------------------------------------------
// Invoice-level dues history for one patient.
// GET /api/admin/reports/patient-dues/{patientId}
// ============================================================

class PatientDuesHistoryPage extends StatelessWidget {
  const PatientDuesHistoryPage({
    super.key,
    required this.patientId,
    required this.patientName,
    required this.cnic,
    required this.phone,
  });

  final String patientId;
  final String patientName;
  final String cnic;
  final String phone;

  bool _isLoading(PatientDuesHistoryState state) {
    if (state is PatientDuesHistoryLoading ||
        state is PatientDuesHistoryInitial) {
      return true;
    }
    if (state is PatientDuesHistoryLoaded) return state.isRefreshing;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<PatientDuesHistoryBloc>()
            ..add(PatientDuesHistoryStarted(patientId)),
      child: BlocConsumer<PatientDuesHistoryBloc, PatientDuesHistoryState>(
        listener: (context, state) {
          if (state is PatientDuesHistoryError) {
            AppSnackbar.error(context, state.message, title: state.title);
          }
        },
        builder: (context, state) {
          final isFirstLoad =
              state is PatientDuesHistoryLoading ||
              state is PatientDuesHistoryInitial;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: FormBackAppBar(
              title: 'Patient Dues History',
              isLoading: _isLoading(state),
            ),
            body: AppTabletSafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PatientDuesHistoryHeader(
                    patientName: patientName,
                    cnic: cnic,
                    phone: phone,
                  ),
                  Divider(height: 1.h, color: AppColors.divider),
                  Expanded(
                    child: AppPullRefresh(
                      enabled: !isFirstLoad,
                      onRefresh: () =>
                          context.read<PatientDuesHistoryBloc>().pullRefresh(),
                      child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: ClampingScrollPhysics(),
                        ),
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.fromLTRB(
                              16.w,
                              16.h,
                              16.w,
                              16.h,
                            ),
                            sliver: SliverToBoxAdapter(
                              child: isFirstLoad
                                  ? const AppShimmer(
                                      child: PatientDuesHistoryTableSkeleton(),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.surface,
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                        border: Border.all(
                                          color: AppColors.border,
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: PatientDuesHistoryTable(
                                        rows: state is PatientDuesHistoryLoaded
                                            ? state.rows
                                            : const [],
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
