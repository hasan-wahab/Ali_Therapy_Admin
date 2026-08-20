part of 'report_filter_options_bloc.dart';

abstract class ReportFilterOptionsEvent extends Equatable {
  const ReportFilterOptionsEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched when a report screen opens — loads filter dropdowns once.
class ReportFilterOptionsStarted extends ReportFilterOptionsEvent {
  const ReportFilterOptionsStarted();
}
