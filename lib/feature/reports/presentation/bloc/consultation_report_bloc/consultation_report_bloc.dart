import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'consultation_report_event.dart';
part 'consultation_report_state.dart';

// ============================================================
// CONSULTATIONREPORT BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class ConsultationReportBloc extends Bloc<ConsultationReportEvent, ConsultationReportState> {
  ConsultationReportBloc() : super(const ConsultationReportInitial()) {
    on<ConsultationReportStarted>(_onStarted);
  }

  Future<void> _onStarted(
    ConsultationReportStarted event,
    Emitter<ConsultationReportState> emit,
  ) async {
    // TODO: call GetConsultationReportUseCase when API is ready.
    emit(const ConsultationReportInitial());
  }
}
