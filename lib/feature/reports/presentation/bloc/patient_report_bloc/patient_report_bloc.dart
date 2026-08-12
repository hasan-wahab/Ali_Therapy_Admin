import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_report_event.dart';
part 'patient_report_state.dart';

// ============================================================
// PATIENTREPORT BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class PatientReportBloc extends Bloc<PatientReportEvent, PatientReportState> {
  PatientReportBloc() : super(const PatientReportInitial()) {
    on<PatientReportStarted>(_onStarted);
  }

  Future<void> _onStarted(
    PatientReportStarted event,
    Emitter<PatientReportState> emit,
  ) async {
    // TODO: call GetPatientReportUseCase when API is ready.
    emit(const PatientReportInitial());
  }
}
