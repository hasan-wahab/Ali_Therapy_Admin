part of 'all_employees_bloc.dart';

abstract class AllEmployeesEvent extends Equatable {
  const AllEmployeesEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class AllEmployeesStarted extends AllEmployeesEvent {
  const AllEmployeesStarted();
}

/// Pull-to-refresh — keep old list on screen (no skeleton).
/// [completer] finishes when API call ends (so UI can hide indicator).
class AllEmployeesRefreshed extends AllEmployeesEvent {
  const AllEmployeesRefreshed({required this.completer});

  final Completer<void> completer;
}
