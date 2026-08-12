import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'refer_by_report_event.dart';
part 'refer_by_report_state.dart';

// ============================================================
// REFERBYREPORT BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class ReferByReportBloc extends Bloc<ReferByReportEvent, ReferByReportState> {
  ReferByReportBloc() : super(const ReferByReportInitial()) {
    on<ReferByReportStarted>(_onStarted);
  }

  Future<void> _onStarted(
    ReferByReportStarted event,
    Emitter<ReferByReportState> emit,
  ) async {
    // TODO: call GetReferByReportUseCase when API is ready.
    emit(const ReferByReportInitial());
  }
}
