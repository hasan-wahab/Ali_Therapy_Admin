part of 'receptionist_report_bloc.dart';

abstract class ReceptionistReportEvent extends Equatable {
  const ReceptionistReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class ReceptionistReportStarted extends ReceptionistReportEvent {
  const ReceptionistReportStarted();
}
