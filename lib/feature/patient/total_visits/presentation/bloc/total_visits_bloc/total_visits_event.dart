part of 'total_visits_bloc.dart';

abstract class TotalVisitsEvent extends Equatable {
  const TotalVisitsEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class TotalVisitsStarted extends TotalVisitsEvent {
  const TotalVisitsStarted();
}
