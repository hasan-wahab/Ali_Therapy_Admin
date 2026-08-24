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
  const HomeLoaded({
    required this.dashboard,
    this.isRefreshingList = false,
  });

  final DashboardEntity dashboard;

  /// True during pull refresh — content stays, AppBar shows loading.
  final bool isRefreshingList;

  HomeLoaded copyWith({
    DashboardEntity? dashboard,
    bool? isRefreshingList,
  }) {
    return HomeLoaded(
      dashboard: dashboard ?? this.dashboard,
      isRefreshingList: isRefreshingList ?? this.isRefreshingList,
    );
  }

  @override
  List<Object?> get props => [dashboard, isRefreshingList];
}

class HomeError extends HomeState {
  const HomeError({
    required this.title,
    required this.message,
    this.dashboard,
    this.isRefreshingList = false,
  });

  final String title;
  final String message;
  final DashboardEntity? dashboard;
  final bool isRefreshingList;

  @override
  List<Object?> get props => [title, message, dashboard, isRefreshingList];
}
