part of 'home_bloc.dart';

// ============================================================
// HOME EVENTS
// ============================================================

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// Load dashboard stats.
class HomeDashboardRequested extends HomeEvent {
  const HomeDashboardRequested();
}

/// Refresh dashboard stats.
class HomeDashboardRefreshed extends HomeEvent {
  const HomeDashboardRefreshed();
}
