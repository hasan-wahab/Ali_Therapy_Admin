import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';

import '../../../domain/patient_registration_domain/entities/patient_create_form_entity.dart';
import '../../../domain/patient_registration_domain/entities/patient_form_data_entity.dart';
import '../../../domain/patient_registration_domain/usecases/create_patient_usecase.dart';
import '../../../domain/patient_registration_domain/usecases/get_patient_details_usecase.dart';
import '../../../domain/patient_registration_domain/usecases/get_patient_form_data_usecase.dart';

part 'patient_registration_event.dart';
part 'patient_registration_state.dart';

// ============================================================
// PATIENT REGISTRATION BLOC
// ------------------------------------------------------------
// Started   → GET patients/form-data (cached after first Create Patient)
//             + GET patient/{id}/full-view when editing
// Submitted → POST patients/create
// ============================================================

class PatientRegistrationBloc
    extends Bloc<PatientRegistrationEvent, PatientRegistrationState> {
  PatientRegistrationBloc({
    required this.getPatientFormDataUseCase,
    required this.getPatientDetailsUseCase,
    required this.createPatientUseCase,
  }) : super(const PatientRegistrationInitial()) {
    on<PatientRegistrationStarted>(_onStarted);
    on<PatientRegistrationSubmitted>(_onSubmitted);
  }

  final GetPatientFormDataUseCase getPatientFormDataUseCase;
  final GetPatientDetailsUseCase getPatientDetailsUseCase;
  final CreatePatientUseCase createPatientUseCase;

  Future<void> _onStarted(
    PatientRegistrationStarted event,
    Emitter<PatientRegistrationState> emit,
  ) async {
    final editId = event.patientId?.trim();
    if (editId != null && (editId.isEmpty || editId == '_')) {
      emit(
        const PatientRegistrationError(
          title: 'Missing Id',
          message: 'Patient id is missing. Open Edit from All Patients again.',
        ),
      );
      return;
    }

    emit(const PatientRegistrationLoading());

    final formResult = await getPatientFormDataUseCase(const NoParams());
    final formData = formResult.when(
      success: (data) => data,
      failure: (failure) {
        emit(
          PatientRegistrationError(
            title: failure.title,
            message: failure.message,
          ),
        );
        return null;
      },
    );
    if (formData == null) return;

    if (editId == null) {
      emit(PatientRegistrationLoaded(formData: formData));
      return;
    }

    final patientResult = await getPatientDetailsUseCase(
      GetPatientDetailsParams(patientId: editId),
    );

    patientResult.when(
      success: (patient) => emit(
        PatientRegistrationLoaded(
          formData: formData,
          patient: patient,
        ),
      ),
      failure: (failure) => emit(
        PatientRegistrationError(
          title: failure.title,
          message: failure.message,
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    PatientRegistrationSubmitted event,
    Emitter<PatientRegistrationState> emit,
  ) async {
    final current = state;
    if (current is! PatientRegistrationLoaded) return;
    if (current.isSaving) return;

    emit(current.copyWith(isSaving: true, successMessage: null));

    final result = await createPatientUseCase(
      CreatePatientParams(form: event.form),
    );

    result.when(
      success: (data) {
        emit(
          current.copyWith(
            isSaving: false,
            successMessage: data.displayMessage,
          ),
        );
      },
      failure: (failure) {
        emit(
          PatientRegistrationError(
            title: failure.title,
            message: failure.message,
          ),
        );
        emit(current.copyWith(isSaving: false, successMessage: null));
      },
    );
  }
}
