part of 'patient_registration_bloc.dart';

abstract class PatientRegistrationEvent extends Equatable {
  const PatientRegistrationEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened — load GET patients/form-data
/// Pass [patientId] for Edit so GET patient/{id} also runs.
class PatientRegistrationStarted extends PatientRegistrationEvent {
  const PatientRegistrationStarted({this.patientId});

  final String? patientId;

  @override
  List<Object?> get props => [patientId];
}

/// Last-step Register — POST /patients/create
class PatientRegistrationSubmitted extends PatientRegistrationEvent {
  const PatientRegistrationSubmitted({required this.form});

  final PatientCreateFormEntity form;

  @override
  List<Object?> get props => [form];
}

/// Last-step Update — POST /patients/{id}/update
class PatientRegistrationUpdated extends PatientRegistrationEvent {
  const PatientRegistrationUpdated({
    required this.patientId,
    required this.form,
  });

  final String patientId;
  final PatientCreateFormEntity form;

  @override
  List<Object?> get props => [patientId, form];
}
