part of 'all_patients_bloc.dart';

abstract class AllPatientsEvent extends Equatable {
  const AllPatientsEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load (page 1).
class AllPatientsStarted extends AllPatientsEvent {
  const AllPatientsStarted();
}

/// Pull-to-refresh — reload page 1 (list stays visible).
class AllPatientsRefreshed extends AllPatientsEvent {
  const AllPatientsRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

/// Scroll near bottom — load next page and append.
class AllPatientsLoadMore extends AllPatientsEvent {
  const AllPatientsLoadMore();
}

/// Search text changed (starts debounce; does not hit API yet).
class AllPatientsSearchChanged extends AllPatientsEvent {
  const AllPatientsSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Debounced search ready → reload page 1.
class AllPatientsSearchSubmitted extends AllPatientsEvent {
  const AllPatientsSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Filter dropdowns / dates applied → reload page 1.
class AllPatientsFiltersApplied extends AllPatientsEvent {
  const AllPatientsFiltersApplied({
    this.clinic,
    this.receptionist,
    this.fromDate,
    this.toDate,
    this.perPage,
    this.clearFromDate = false,
    this.clearToDate = false,
    this.resetAll = false,
  });

  final String? clinic;
  final String? receptionist;
  final String? fromDate;
  final String? toDate;
  final int? perPage;
  final bool clearFromDate;
  final bool clearToDate;
  final bool resetAll;

  @override
  List<Object?> get props => [
        clinic,
        receptionist,
        fromDate,
        toDate,
        perPage,
        clearFromDate,
        clearToDate,
        resetAll,
      ];
}
