part of 'all_employees_bloc.dart';

abstract class AllEmployeesEvent extends Equatable {
  const AllEmployeesEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load (page 1).
class AllEmployeesStarted extends AllEmployeesEvent {
  const AllEmployeesStarted();
}

/// Pull-to-refresh — reload page 1 (list stays visible).
class AllEmployeesRefreshed extends AllEmployeesEvent {
  const AllEmployeesRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

/// Scroll near bottom — load next page and append.
class AllEmployeesLoadMore extends AllEmployeesEvent {
  const AllEmployeesLoadMore();
}
