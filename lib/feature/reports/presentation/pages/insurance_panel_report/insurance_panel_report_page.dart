import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_pull_refresh.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_summary_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/insurance_panel_report_bloc/insurance_panel_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/insurance_panel_card_list.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/insurance_panel_card_skeleton.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/insurance_panel_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/insurance_panel_totals.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// INSURANCE PANEL REPORT PAGE
// ------------------------------------------------------------
// Same screen flow as ReferByReportPage (no load-more —
// this API returns the full list + summary).
// ============================================================

class InsurancePanelReportPage extends StatelessWidget {
  const InsurancePanelReportPage({super.key});

  List<InsurancePanelReportEntity> _rowsOf(InsurancePanelReportState state) {
    if (state is InsurancePanelReportLoaded) return state.rows;
    if (state is InsurancePanelReportError) return state.rows;
    return const [];
  }

  InsurancePanelReportSummaryEntity _summaryOf(
    InsurancePanelReportState state,
  ) {
    if (state is InsurancePanelReportLoaded) return state.summary;
    if (state is InsurancePanelReportError) return state.summary;
    return const InsurancePanelReportSummaryEntity.empty();
  }

  bool _showTotalsOf(InsurancePanelReportState state) {
    if (state is InsurancePanelReportLoaded) return state.showTotals;
    if (state is InsurancePanelReportError) return state.showTotals;
    return false;
  }

  bool _isLoading(InsurancePanelReportState state) {
    if (state is InsurancePanelReportLoading ||
        state is InsurancePanelReportInitial) {
      return true;
    }
    if (state is InsurancePanelReportLoaded) return state.isRefreshingList;
    return false;
  }

  Widget _totalsHeader({
    required BuildContext context,
    required InsurancePanelReportSummaryEntity summary,
    required bool showTotals,
  }) {
    return InsurancePanelTotals(
      totalInvoices: summary.totalInvoices,
      consultationBilled: InsurancePanelCardList.pkr(
        summary.consultationBilled,
      ),
      packageBilled: InsurancePanelCardList.pkr(summary.packageBilled),
      totalBilled: InsurancePanelCardList.pkr(summary.totalBilled),
      totalCovered: InsurancePanelCardList.pkr(summary.totalCovered),
      totalPaidCash: InsurancePanelCardList.pkr(summary.totalPaidCash),
      outstandingBalance: InsurancePanelCardList.pkr(
        summary.outstandingBalance,
      ),
      expanded: showTotals,
      onToggle: () {
        context.read<InsurancePanelReportBloc>().add(
              const InsurancePanelReportTotalsToggled(),
            );
      },
    );
  }

  Widget _listContent({
    required BuildContext context,
    required InsurancePanelReportState state,
    required bool isFirstLoad,
    required double hPad,
  }) {
    final listScroll = CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      slivers: [
        if (!isFirstLoad)
          SliverPadding(
            padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 12.h),
            sliver: SliverToBoxAdapter(
              child: _totalsHeader(
                context: context,
                summary: _summaryOf(state),
                showTotals: _showTotalsOf(state),
              ),
            ),
          ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 8.h),
          sliver: isFirstLoad
              ? const InsurancePanelCardSkeletonSliver(itemCount: 5)
              : InsurancePanelCardList(rows: _rowsOf(state)),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 16.h)),
      ],
    );

    final listBody = isFirstLoad ? AppShimmer(child: listScroll) : listScroll;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(hPad, 8.h, hPad, 12.h),
          child: const InsurancePanelSearchFilterSection(),
        ),
        Expanded(
          child: AppPullRefresh(
            enabled: !isFirstLoad,
            onRefresh: () =>
                context.read<InsurancePanelReportBloc>().pullRefresh(),
            child: listBody,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<InsurancePanelReportBloc>()
        ..add(const InsurancePanelReportStarted()),
      child: BlocConsumer<InsurancePanelReportBloc, InsurancePanelReportState>(
        listener: (context, state) {
          if (state is InsurancePanelReportError) {
            AppSnackbar.error(context, state.message, title: state.title);
          }
        },
        builder: (context, state) {
          final isFirstLoad = state is InsurancePanelReportLoading ||
              state is InsurancePanelReportInitial;
          final isLoading = _isLoading(state);
          final isTablet = AppDevice.isTablet(context);

          final hPad = isTablet
              ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
              : 16.w;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: FormBackAppBar(
              title: 'Insurance Panel Report',
              isLoading: isLoading,
            ),
            body: AppTabletSafeArea(
              child: _listContent(
                context: context,
                state: state,
                isFirstLoad: isFirstLoad,
                hPad: hPad,
              ),
            ),
          );
        },
      ),
    );
  }
}
