part of 'therapy_sessions_bloc.dart';

abstract class TherapySessionsEvent extends Equatable {
  const TherapySessionsEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class TherapySessionsStarted extends TherapySessionsEvent {
  const TherapySessionsStarted();
}
