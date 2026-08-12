import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'free_consultation_report_event.dart';
part 'free_consultation_report_state.dart';

// ============================================================
// FREECONSULTATIONREPORT BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class FreeConsultationReportBloc extends Bloc<FreeConsultationReportEvent, FreeConsultationReportState> {
  FreeConsultationReportBloc() : super(const FreeConsultationReportInitial()) {
    on<FreeConsultationReportStarted>(_onStarted);
  }

  Future<void> _onStarted(
    FreeConsultationReportStarted event,
    Emitter<FreeConsultationReportState> emit,
  ) async {
    // TODO: call GetFreeConsultationReportUseCase when API is ready.
    emit(const FreeConsultationReportInitial());
  }
}
