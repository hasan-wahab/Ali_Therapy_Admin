part of 'patient_detail_bloc.dart';

abstract class PatientDetailEvent extends Equatable {
  const PatientDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class PatientDetailStarted extends PatientDetailEvent {
  const PatientDetailStarted();
}
