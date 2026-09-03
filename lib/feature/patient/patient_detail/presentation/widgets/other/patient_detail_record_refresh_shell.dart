import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_pull_refresh.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/entities/patient_detail_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/bloc/patient_detail_bloc/patient_detail_bloc.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// PATIENT DETAIL RECORD REFRESH SHELL
// ------------------------------------------------------------
// Record screens opened from Profile overview / Records.
// Shows extra data first. Pull refresh reloads Full View.
// Loading = AppBar underline only.
// ============================================================

class PatientDetailRecordRefreshShell extends StatelessWidget {
  const PatientDetailRecordRefreshShell({
    super.key,
    required this.title,
    required this.builder,
  });

  final String title;
  final Widget Function(
    BuildContext context,
    PatientDetailEntity detail,
  ) builder;

  PatientDetailEntity? _seedFromRoute(BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    if (extra is PatientDetailEntity) return extra;
    return null;
  }

  String _patientIdOf(PatientDetailEntity? seed) {
    final id = seed?.profile.id.trim() ?? '';
    if (id.isEmpty || id == '_') return '';
    return id;
  }

  PatientDetailEntity? _detailOf(
    PatientDetailState state,
    PatientDetailEntity? seed,
  ) {
    if (state is PatientDetailLoaded) return state.detail;
    if (state is PatientDetailError) return state.detail ?? seed;
    return seed;
  }

  @override
  Widget build(BuildContext context) {
    final seed = _seedFromRoute(context);
    final patientId = _patientIdOf(seed);

    return BlocProvider(
      create: (_) {
        final bloc = sl<PatientDetailBloc>();
        if (patientId.isNotEmpty) {
          bloc.add(
            PatientDetailStarted(patientId: patientId, seed: seed),
          );
        }
        return bloc;
      },
      child: BlocConsumer<PatientDetailBloc, PatientDetailState>(
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
          final isRefreshing =
              state is PatientDetailLoaded && state.isRefreshing;
          final detail = _detailOf(state, seed) ?? const PatientDetailEntity();

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: FormBackAppBar(
              title: title,
              isLoading: isRefreshing,
            ),
            body: AppTabletSafeArea(
              child: AppPullRefresh(
                enabled: patientId.isNotEmpty && !isRefreshing,
                showTopLoader: false,
                onRefresh: () =>
                    context.read<PatientDetailBloc>().pullRefresh(),
                child: builder(context, detail),
              ),
            ),
          );
        },
      ),
    );
  }
}
