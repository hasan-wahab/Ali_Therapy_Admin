part of 'therapy_sessions_bloc.dart';

abstract class TherapySessionsState extends Equatable {
  const TherapySessionsState();

  @override
  List<Object?> get props => [];
}

class TherapySessionsInitial extends TherapySessionsState {
  const TherapySessionsInitial();
}

class TherapySessionsLoading extends TherapySessionsState {
  const TherapySessionsLoading();
}

class TherapySessionsError extends TherapySessionsState {
  final String message;

  const TherapySessionsError(this.message);

  @override
  List<Object?> get props => [message];
}
