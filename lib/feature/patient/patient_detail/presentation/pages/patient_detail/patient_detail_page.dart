import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_permission.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_pull_refresh.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/entities/patient_detail_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/bloc/patient_detail_bloc/patient_detail_bloc.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_skeleton.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_tab.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_tab_bar.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/sections/profile/patient_detail_profile_section.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/sections/progress/patient_detail_progress_section.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/sections/records/patient_detail_records_section.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/sections/survey/patient_detail_survey_section.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// PATIENT DETAIL PAGE
// ------------------------------------------------------------
// Opened from All Patients → View with patient id in extra.
// View (first load) → shimmer skeleton.
// Pull refresh → AppBar underline; content stays on screen.
// ============================================================

class PatientDetailPage extends StatefulWidget {
  const PatientDetailPage({super.key});

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  PatientDetailTab _activeTab = PatientDetailTab.profile;

  String? _patientIdFromRoute() {
    final extra = GoRouterState.of(context).extra;
    if (extra is String && extra.trim().isNotEmpty && extra != '_') {
      return extra.trim();
    }
    return null;
  }

  bool _isRefreshing(PatientDetailState state) {
    return state is PatientDetailLoaded && state.isRefreshing;
  }

  PatientDetailEntity? _detailOf(PatientDetailState state) {
    if (state is PatientDetailLoaded) return state.detail;
    if (state is PatientDetailError) return state.detail;
    return null;
  }

  Widget _buildSection(PatientDetailEntity detail) {
    switch (_activeTab) {
      case PatientDetailTab.profile:
        return PatientDetailProfileSection(detail: detail);
      case PatientDetailTab.records:
        return PatientDetailRecordsSection(detail: detail);
      case PatientDetailTab.progress:
        return PatientDetailProgressSection(detail: detail);
      case PatientDetailTab.survey:
        return PatientDetailSurveySection(detail: detail);
    }
  }

  Widget _wrapScroll({
    required BuildContext context,
    required bool isTablet,
    required double hPad,
    required bool refreshEnabled,
    required Widget child,
  }) {
    final scrollView = SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      padding: EdgeInsets.fromLTRB(hPad, 8.h, hPad, 24.h),
      child: child,
    );

    final boundedScroll = isTablet
        ? Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppDevice.contentMaxWidth(context),
              ),
              child: scrollView,
            ),
          )
        : scrollView;

    return AppPullRefresh(
      enabled: refreshEnabled,
      showTopLoader: false,
      onRefresh: () => context.read<PatientDetailBloc>().pullRefresh(),
      child: boundedScroll,
    );
  }

  @override
  Widget build(BuildContext context) {
    final patientId = _patientIdFromRoute();
    final isTablet = AppDevice.isTablet(context);
    final hPad = isTablet
        ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
        : 16.w;

    return BlocProvider(
      create: (_) {
        final bloc = sl<PatientDetailBloc>();
        if (patientId != null) {
          bloc.add(PatientDetailStarted(patientId: patientId));
        }
        return bloc;
      },
      child: patientId == null
          ? Scaffold(
              backgroundColor: AppColors.background,
              appBar: const FormBackAppBar(title: 'Detail'),
              body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      'Open a patient from All Patients → View.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                  ),
                ),
              ),
            )
          : BlocConsumer<PatientDetailBloc, PatientDetailState>(
              listener: (context, state) {
                if (state is PatientDetailError) {
                  AppSnackbar.error(
                    context,
                    state.message,
                    title: state.title,
                  );
                }
              },
              builder: (context, state) {
                final isRefreshing = _isRefreshing(state);
                final isFirstLoad = state is PatientDetailLoading ||
                    state is PatientDetailInitial;
                final detail = _detailOf(state);

                Widget scrollChild;
                if (isFirstLoad) {
                  scrollChild = const AppShimmer(
                    child: PatientDetailSkeleton(),
                  );
                } else if (detail == null) {
                  scrollChild = const SizedBox(height: 1);
                } else {
                  scrollChild = Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PatientDetailTabBar(
                        activeTab: _activeTab,
                        showSurvey: AppPermission.canViewSurvey,
                        onTabSelected: (tab) {
                          setState(() => _activeTab = tab);
                        },
                      ),
                      SizedBox(height: 12.h),
                      _buildSection(detail),
                    ],
                  );
                }

                return Scaffold(
                  backgroundColor: AppColors.background,
                  appBar: FormBackAppBar(
                    title: 'Detail',
                    isLoading: isRefreshing,
                  ),
                  body: SafeArea(
                    child: _wrapScroll(
                      context: context,
                      isTablet: isTablet,
                      hPad: hPad,
                      refreshEnabled: !isFirstLoad && !isRefreshing,
                      child: scrollChild,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
