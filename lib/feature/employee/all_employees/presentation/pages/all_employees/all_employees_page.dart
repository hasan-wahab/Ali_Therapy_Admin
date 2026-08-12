import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_list_card_skeleton.dart';
import 'package:ali_therapy_admin/core/widgets/app_pull_refresh.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employee_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/bloc/all_employees_bloc/all_employees_bloc.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employee_card_list.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_search_field.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// ALL EMPLOYEES PAGE
// ------------------------------------------------------------
// Search fixed. Cards scroll.
// Pull refresh → shared AppPullRefresh (reusable).
// ============================================================

class AllEmployeesPage extends StatelessWidget {
  const AllEmployeesPage({super.key});

  List<EmployeeEntity> _employeesOf(AllEmployeesState state) {
    if (state is AllEmployeesLoaded) return state.employees;
    if (state is AllEmployeesError) return state.employees;
    return const [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AllEmployeesBloc>()..add(const AllEmployeesStarted()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const FormBackAppBar(title: 'All Employees'),
        body: SafeArea(
          child: BlocConsumer<AllEmployeesBloc, AllEmployeesState>(
            listener: (context, state) {
              if (state is AllEmployeesError) {
                AppSnackbar.error(context, state.message, title: state.title);
              }
            },
            builder: (context, state) {
              final isFirstLoad =
                  state is AllEmployeesLoading || state is AllEmployeesInitial;

              final listScroll = CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: ClampingScrollPhysics(),
                ),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                    sliver: isFirstLoad
                        ? const AppListCardSkeletonSliver(itemCount: 6)
                        : EmployeeCardList(employees: _employeesOf(state)),
                  ),
                ],
              );

              final listBody = isFirstLoad
                  ? AppShimmer(child: listScroll)
                  : listScroll;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
                    child: const EmployeesSearchField(),
                  ),
                  Expanded(
                    child: AppPullRefresh(
                      enabled: !isFirstLoad,
                      onRefresh: () =>
                          context.read<AllEmployeesBloc>().pullRefresh(),
                      child: listBody,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
