import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_registration_event.dart';
part 'patient_registration_state.dart';

// ============================================================
// PATIENTREGISTRATION BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class PatientRegistrationBloc extends Bloc<PatientRegistrationEvent, PatientRegistrationState> {
  PatientRegistrationBloc() : super(const PatientRegistrationInitial()) {
    on<PatientRegistrationStarted>(_onStarted);
  }

  Future<void> _onStarted(
    PatientRegistrationStarted event,
    Emitter<PatientRegistrationState> emit,
  ) async {
    // TODO: call GetPatientRegistrationUseCase when API is ready.
    emit(const PatientRegistrationInitial());
  }
}
