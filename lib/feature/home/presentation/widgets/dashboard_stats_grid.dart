import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_permission.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_entity.dart';
import 'package:ali_therapy_admin/feature/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_stat_card.dart';

// ============================================================
// DASHBOARD STATS GRID
// ------------------------------------------------------------
// Overview cards from GET dashboard/overview.
// Hidden when the matching permission is missing.
// ============================================================

class DashboardStatsGrid extends StatelessWidget {
  const DashboardStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final dashboard = state is HomeLoaded
            ? state.dashboard
            : (state is HomeError
                ? (state.dashboard ?? DashboardEntity.empty())
                : DashboardEntity.empty());

        final cards = <Widget>[
          if (AppPermission.canViewEmployees)
            DashboardStatCard(
              title: dashboard.totalEmployees.title,
              value: dashboard.totalEmployees.formattedValue,
              accentColor: AppColors.primary,
            ),
          if (AppPermission.canViewPatients)
            DashboardStatCard(
              title: dashboard.totalPatients.title,
              value: dashboard.totalPatients.formattedValue,
              subtitle: dashboard.totalPatients.subtitle,
              accentColor: AppColors.success,
            ),
          if (AppPermission.canViewFinance || AppPermission.canViewReportsHub)
            DashboardStatCard(
              title: dashboard.monthlyIncome.title,
              value: dashboard.monthlyIncome.formattedValue,
              subtitle: dashboard.monthlyIncome.subtitle,
              accentColor: AppColors.info,
            ),
          if (AppPermission.canViewFinance || AppPermission.canViewReportsHub)
            DashboardStatCard(
              title: dashboard.monthlyExpenses.title,
              value: dashboard.monthlyExpenses.formattedValue,
              subtitle: dashboard.monthlyExpenses.subtitle,
              accentColor: AppColors.error,
            ),
        ];

        if (cards.isEmpty) return const SizedBox.shrink();

        return Column(children: _rowsOf(cards));
      },
    );
  }

  List<Widget> _rowsOf(List<Widget> cards) {
    final rows = <Widget>[];
    for (var i = 0; i < cards.length; i += 2) {
      if (i > 0) rows.add(SizedBox(height: 8.h));
      if (i + 1 < cards.length) {
        rows.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: cards[i]),
              SizedBox(width: 8.w),
              Expanded(child: cards[i + 1]),
            ],
          ),
        );
      } else {
        rows.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: cards[i]),
              SizedBox(width: 8.w),
              const Expanded(child: SizedBox.shrink()),
            ],
          ),
        );
      }
    }
    return rows;
  }
}
