import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_dues_event.dart';
part 'patient_dues_state.dart';

// ============================================================
// PATIENTDUES BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class PatientDuesBloc extends Bloc<PatientDuesEvent, PatientDuesState> {
  PatientDuesBloc() : super(const PatientDuesInitial()) {
    on<PatientDuesStarted>(_onStarted);
  }

  Future<void> _onStarted(
    PatientDuesStarted event,
    Emitter<PatientDuesState> emit,
  ) async {
    // TODO: call GetPatientDuesUseCase when API is ready.
    emit(const PatientDuesInitial());
  }
}
