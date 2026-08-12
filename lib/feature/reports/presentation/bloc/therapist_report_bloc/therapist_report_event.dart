part of 'therapist_report_bloc.dart';

abstract class TherapistReportEvent extends Equatable {
  const TherapistReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class TherapistReportStarted extends TherapistReportEvent {
  const TherapistReportStarted();
}
