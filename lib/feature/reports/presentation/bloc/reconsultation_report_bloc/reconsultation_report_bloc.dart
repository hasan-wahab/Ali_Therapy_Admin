import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reconsultation_report_event.dart';
part 'reconsultation_report_state.dart';

// ============================================================
// RECONSULTATIONREPORT BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class ReconsultationReportBloc extends Bloc<ReconsultationReportEvent, ReconsultationReportState> {
  ReconsultationReportBloc() : super(const ReconsultationReportInitial()) {
    on<ReconsultationReportStarted>(_onStarted);
  }

  Future<void> _onStarted(
    ReconsultationReportStarted event,
    Emitter<ReconsultationReportState> emit,
  ) async {
    // TODO: call GetReconsultationReportUseCase when API is ready.
    emit(const ReconsultationReportInitial());
  }
}
