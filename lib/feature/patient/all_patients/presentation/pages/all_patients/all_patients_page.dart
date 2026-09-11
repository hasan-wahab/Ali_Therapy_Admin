import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_list_card_skeleton.dart';
import 'package:ali_therapy_admin/core/widgets/app_loading_dialog.dart';
import 'package:ali_therapy_admin/core/widgets/app_pull_refresh.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/domain/all_patients_domain/entities/patient_entity.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/domain/all_patients_domain/entities/patients_list_query.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/bloc/all_patients_bloc/all_patients_bloc.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patient_card_list.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_filters_panel.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_search_filter_section.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// ALL PATIENTS PAGE
// ------------------------------------------------------------
// Search fixed. Cards scroll.
// Pull refresh → page 1.
// AppBar underline: rainbow normally, teal linear during any load.
// ============================================================

class AllPatientsPage extends StatelessWidget {
  const AllPatientsPage({super.key});

  static const int _prefetchRemainingCards = 2;

  double get _approxCardHeight => 280.h;

  List<PatientEntity> _patientsOf(AllPatientsState state) {
    if (state is AllPatientsLoaded) return state.patients;
    if (state is AllPatientsError) return state.patients;
    return const [];
  }

  bool _isLoading(AllPatientsState state) {
    if (state is AllPatientsLoading || state is AllPatientsInitial) {
      return true;
    }
    if (state is AllPatientsLoaded) {
      return state.isRefreshingList ||
          state.isLoadingMore ||
          state.deletingPatientId != null;
    }
    return false;
  }

  List<String> _searchFields(PatientEntity row) => [
        row.name,
        row.id,
        row.cnic,
        ...row.problems,
        row.insurance,
        row.createdBy,
        row.receptionist,
        row.assistantManager,
        row.consultant,
        row.therapist,
      ];

  bool _onScroll(BuildContext context, ScrollNotification notification) {
    if (notification is! ScrollUpdateNotification) return false;

    final metrics = notification.metrics;
    final remainingBelow = metrics.extentAfter;
    final prefetchDistance =
        (_prefetchRemainingCards * _approxCardHeight) + 20.h;

    if (remainingBelow > prefetchDistance) return false;

    context.read<AllPatientsBloc>().add(const AllPatientsLoadMore());
    return false;
  }

  Widget _listContent({
    required BuildContext context,
    required AllPatientsState state,
    required bool isFirstLoad,
    required double hPad,
  }) {
    final patients = _patientsOf(state);
    final query = state is AllPatientsLoaded
        ? state.query
        : state is AllPatientsError
            ? state.query
            : null;
    final searchQuery = query?.search ?? '';
    final clinicLabel = (query == null || query.clinic.isEmpty)
        ? PatientsFiltersPanel.allClinics
        : query.clinic;
    final receptionistLabel =
        (query == null || query.receptionist.isEmpty)
            ? PatientsFiltersPanel.allReceptionists
            : query.receptionist;
    final isSearchBusy = state is AllPatientsLoaded && state.isRefreshingList;

    final listScroll = NotificationListener<ScrollNotification>(
      onNotification: (notification) => _onScroll(context, notification),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 8.h),
            sliver: isFirstLoad
                ? const AppListCardSkeletonSliver(itemCount: 6)
                : PatientCardList(patients: patients),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
        ],
      ),
    );

    final listBody = isFirstLoad ? AppShimmer(child: listScroll) : listScroll;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(hPad, 8.h, hPad, 12.h),
          child: PatientsSearchFilterSection(
            clinic: clinicLabel,
            receptionist: receptionistLabel,
            fromDate: query?.dateFrom,
            toDate: query?.dateTo,
            perPage: query?.perPage ?? PatientsListPerPage.defaultSize,
            searchQuery: searchQuery,
            searchMatchCount: AppSearchRanker.matchCount(
              items: patients,
              query: searchQuery,
              fieldsOf: _searchFields,
            ),
            listIsEmpty: !isFirstLoad && patients.isEmpty,
            hasActiveFilters: query?.hasActiveFilters ?? false,
            isSearchBusy: isSearchBusy,
            onSearchChanged: (value) {
              context.read<AllPatientsBloc>().add(
                    AllPatientsSearchChanged(value),
                  );
            },
            onSearchSubmitted: (value) {
              context.read<AllPatientsBloc>().add(
                    AllPatientsSearchSubmitted(value),
                  );
            },
            onFiltersApply: ({
              required clinic,
              required receptionist,
              fromDate,
              toDate,
              required perPage,
            }) {
              final clinicValue = clinic == PatientsFiltersPanel.allClinics
                  ? ''
                  : clinic;
              final receptionistValue =
                  receptionist == PatientsFiltersPanel.allReceptionists
                      ? ''
                      : receptionist;
              context.read<AllPatientsBloc>().add(
                    AllPatientsFiltersApplied(
                      clinic: clinicValue,
                      receptionist: receptionistValue,
                      fromDate: fromDate,
                      toDate: toDate,
                      perPage: perPage,
                      clearFromDate: fromDate == null,
                      clearToDate: toDate == null,
                    ),
                  );
            },
          ),
        ),
        Expanded(
          child: AppPullRefresh(
            enabled: !isFirstLoad,
            onRefresh: () => context.read<AllPatientsBloc>().pullRefresh(),
            child: listBody,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AllPatientsBloc>()..add(const AllPatientsStarted()),
      child: BlocConsumer<AllPatientsBloc, AllPatientsState>(
        listenWhen: (previous, current) {
          if (current is AllPatientsError) return true;
          if (current is AllPatientsLoaded && current.successMessage != null) {
            final previousMessage = previous is AllPatientsLoaded
                ? previous.successMessage
                : null;
            return previousMessage != current.successMessage;
          }
          return false;
        },
        listener: (context, state) {
          if (state is AllPatientsError) {
            AppSnackbar.error(context, state.message, title: state.title);
          }
          if (state is AllPatientsLoaded &&
              state.successMessage != null &&
              state.successMessage!.isNotEmpty) {
            AppSnackbar.success(context, state.successMessage!);
          }
        },
        builder: (context, state) {
          final isFirstLoad =
              state is AllPatientsLoading || state is AllPatientsInitial;
          final isLoading = _isLoading(state);
          final isTablet = AppDevice.isTablet(context);

          final hPad = isTablet
              ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
              : 16.w;

          final isDeleting =
              state is AllPatientsLoaded && state.deletingPatientId != null;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: FormBackAppBar(
              title: 'All Patients',
              isLoading: isLoading,
            ),
            body: AppTabletSafeArea(
              child: Stack(
                children: [
                  _listContent(
                    context: context,
                    state: state,
                    isFirstLoad: isFirstLoad,
                    hPad: hPad,
                  ),
                  if (isDeleting)
                    const AppLoadingOverlay(
                      message: 'Deleting...',
                      subtitle: 'Please wait',
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
