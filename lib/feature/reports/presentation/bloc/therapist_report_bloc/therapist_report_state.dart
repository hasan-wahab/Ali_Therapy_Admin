part of 'therapist_report_bloc.dart';

abstract class TherapistReportState extends Equatable {
  const TherapistReportState();

  @override
  List<Object?> get props => [];
}

class TherapistReportInitial extends TherapistReportState {
  const TherapistReportInitial();
}

class TherapistReportLoading extends TherapistReportState {
  const TherapistReportLoading();
}

class TherapistReportError extends TherapistReportState {
  final String message;

  const TherapistReportError(this.message);

  @override
  List<Object?> get props => [message];
}
