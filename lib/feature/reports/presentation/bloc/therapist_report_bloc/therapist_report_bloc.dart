import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'therapist_report_event.dart';
part 'therapist_report_state.dart';

// ============================================================
// THERAPISTREPORT BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class TherapistReportBloc extends Bloc<TherapistReportEvent, TherapistReportState> {
  TherapistReportBloc() : super(const TherapistReportInitial()) {
    on<TherapistReportStarted>(_onStarted);
  }

  Future<void> _onStarted(
    TherapistReportStarted event,
    Emitter<TherapistReportState> emit,
  ) async {
    // TODO: call GetTherapistReportUseCase when API is ready.
    emit(const TherapistReportInitial());
  }
}
