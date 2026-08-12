part of 'home_bloc.dart';

// ============================================================
// HOME STATES
// ============================================================

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final DashboardEntity dashboard;

  const HomeLoaded(this.dashboard);

  @override
  List<Object?> get props => [dashboard];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
