import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'receptionist_report_event.dart';
part 'receptionist_report_state.dart';

// ============================================================
// RECEPTIONISTREPORT BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class ReceptionistReportBloc extends Bloc<ReceptionistReportEvent, ReceptionistReportState> {
  ReceptionistReportBloc() : super(const ReceptionistReportInitial()) {
    on<ReceptionistReportStarted>(_onStarted);
  }

  Future<void> _onStarted(
    ReceptionistReportStarted event,
    Emitter<ReceptionistReportState> emit,
  ) async {
    // TODO: call GetReceptionistReportUseCase when API is ready.
    emit(const ReceptionistReportInitial());
  }
}
