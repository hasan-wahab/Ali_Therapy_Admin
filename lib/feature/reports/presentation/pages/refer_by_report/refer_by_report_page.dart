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
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/entities/refer_by_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/refer_by_report_bloc/refer_by_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/refer_by_card_list.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/refer_by_card_skeleton.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/refer_by_search_filter_section.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// REFER BY REPORT PAGE
// ------------------------------------------------------------
// Same screen flow as PatientReportPage (no load-more —
// this API returns the full list).
// ============================================================

class ReferByReportPage extends StatelessWidget {
  const ReferByReportPage({super.key});

  List<ReferByReportEntity> _rowsOf(ReferByReportState state) {
    if (state is ReferByReportLoaded) return state.rows;
    if (state is ReferByReportError) return state.rows;
    return const [];
  }

  bool _isLoading(ReferByReportState state) {
    if (state is ReferByReportLoading || state is ReferByReportInitial) {
      return true;
    }
    if (state is ReferByReportLoaded) return state.isRefreshingList;
    return false;
  }

  Widget _listContent({
    required BuildContext context,
    required ReferByReportState state,
    required bool isFirstLoad,
    required double hPad,
  }) {
    final listScroll = CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 8.h),
          sliver: isFirstLoad
              ? const ReferByCardSkeletonSliver(itemCount: 5)
              : ReferByCardList(rows: _rowsOf(state)),
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
          child: const ReferBySearchFilterSection(),
        ),
        Expanded(
          child: AppPullRefresh(
            enabled: !isFirstLoad,
            onRefresh: () => context.read<ReferByReportBloc>().pullRefresh(),
            child: listBody,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<ReferByReportBloc>()..add(const ReferByReportStarted()),
      child: BlocConsumer<ReferByReportBloc, ReferByReportState>(
        listener: (context, state) {
          if (state is ReferByReportError) {
            AppSnackbar.error(context, state.message, title: state.title);
          }
        },
        builder: (context, state) {
          final isFirstLoad =
              state is ReferByReportLoading || state is ReferByReportInitial;
          final isLoading = _isLoading(state);
          final isTablet = AppDevice.isTablet(context);

          final hPad = isTablet
              ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
              : 16.w;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: FormBackAppBar(
              title: 'Refer By Report',
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
