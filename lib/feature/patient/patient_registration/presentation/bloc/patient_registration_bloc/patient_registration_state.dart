part of 'patient_registration_bloc.dart';

abstract class PatientRegistrationState extends Equatable {
  const PatientRegistrationState();

  @override
  List<Object?> get props => [];
}

class PatientRegistrationInitial extends PatientRegistrationState {
  const PatientRegistrationInitial();
}

class PatientRegistrationLoading extends PatientRegistrationState {
  const PatientRegistrationLoading();
}

class PatientRegistrationLoaded extends PatientRegistrationState {
  const PatientRegistrationLoaded({
    required this.formData,
    this.patient,
    this.isSaving = false,
    this.successMessage,
  });

  final PatientFormDataEntity formData;
  final PatientCreateFormEntity? patient;
  final bool isSaving;
  final String? successMessage;

  PatientRegistrationLoaded copyWith({
    PatientFormDataEntity? formData,
    Object? patient = _keep,
    bool? isSaving,
    Object? successMessage = _keep,
  }) {
    return PatientRegistrationLoaded(
      formData: formData ?? this.formData,
      patient: patient == _keep
          ? this.patient
          : patient as PatientCreateFormEntity?,
      isSaving: isSaving ?? this.isSaving,
      successMessage: successMessage == _keep
          ? this.successMessage
          : successMessage as String?,
    );
  }

  @override
  List<Object?> get props => [formData, patient, isSaving, successMessage];
}

class PatientRegistrationError extends PatientRegistrationState {
  const PatientRegistrationError({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  List<Object?> get props => [title, message];
}

const Object _keep = Object();
