import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/usecases/get_report_filter_options_usecase.dart';

part 'report_filter_options_event.dart';
part 'report_filter_options_state.dart';

// ============================================================
// REPORT FILTER OPTIONS BLOC
// ------------------------------------------------------------
// Load once on report screen open.
// UI listens to state to populate filter dropdowns.
// ============================================================

class ReportFilterOptionsBloc
    extends Bloc<ReportFilterOptionsEvent, ReportFilterOptionsState> {
  ReportFilterOptionsBloc({required this.getFilterOptionsUseCase})
      : super(const ReportFilterOptionsInitial()) {
    on<ReportFilterOptionsStarted>(_onStarted);
  }

  final GetReportFilterOptionsUseCase getFilterOptionsUseCase;

  Future<void> _onStarted(
    ReportFilterOptionsStarted event,
    Emitter<ReportFilterOptionsState> emit,
  ) async {
    // Don't re-fetch if already loaded.
    if (state is ReportFilterOptionsLoaded) return;

    emit(const ReportFilterOptionsLoading());

    final result = await getFilterOptionsUseCase(const NoParams());
    result.when(
      success: (options) =>
          emit(ReportFilterOptionsLoaded(options: options)),
      failure: (failure) => emit(
        ReportFilterOptionsError(
          title: failure.title,
          message: failure.message,
        ),
      ),
    );
  }
}
