part of 'total_visits_bloc.dart';

abstract class TotalVisitsState extends Equatable {
  const TotalVisitsState();

  @override
  List<Object?> get props => [];
}

class TotalVisitsInitial extends TotalVisitsState {
  const TotalVisitsInitial();
}

class TotalVisitsLoading extends TotalVisitsState {
  const TotalVisitsLoading();
}

class TotalVisitsError extends TotalVisitsState {
  final String message;

  const TotalVisitsError(this.message);

  @override
  List<Object?> get props => [message];
}
