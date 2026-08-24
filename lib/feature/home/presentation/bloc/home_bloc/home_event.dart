part of 'home_bloc.dart';

// ============================================================
// HOME EVENTS
// ============================================================

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// First open — full-screen shimmer.
class HomeDashboardRequested extends HomeEvent {
  const HomeDashboardRequested();
}

/// Pull-to-refresh — list stays visible, AppBar loading only.
class HomeDashboardRefreshed extends HomeEvent {
  const HomeDashboardRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}
