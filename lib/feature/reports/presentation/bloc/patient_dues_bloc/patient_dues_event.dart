part of 'patient_dues_bloc.dart';

abstract class PatientDuesEvent extends Equatable {
  const PatientDuesEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load (page 1).
class PatientDuesStarted extends PatientDuesEvent {
  const PatientDuesStarted();
}

/// Pull-to-refresh — reload page 1 (list stays visible).
class PatientDuesRefreshed extends PatientDuesEvent {
  const PatientDuesRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

/// Scroll near bottom — load next page and append.
class PatientDuesLoadMore extends PatientDuesEvent {
  const PatientDuesLoadMore();
}

/// Search text changed (starts debounce).
class PatientDuesSearchChanged extends PatientDuesEvent {
  const PatientDuesSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Debounced search ready → reload page 1.
class PatientDuesSearchSubmitted extends PatientDuesEvent {
  const PatientDuesSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Apply filter button pressed → reload page 1 with new filters.
class PatientDuesFiltersApplied extends PatientDuesEvent {
  const PatientDuesFiltersApplied({
    this.dateFrom,
    this.dateTo,
    this.clinicId,
    this.receptionistId,
    this.perPage,
    this.clearDateFrom = false,
    this.clearDateTo = false,
    this.clearClinicId = false,
    this.clearReceptionistId = false,
    this.resetAll = false,
  });

  final String? dateFrom;
  final String? dateTo;
  final int? clinicId;
  final int? receptionistId;
  final int? perPage;

  final bool clearDateFrom;
  final bool clearDateTo;
  final bool clearClinicId;
  final bool clearReceptionistId;

  /// Reset all filters (keeps current search).
  final bool resetAll;

  @override
  List<Object?> get props => [
        dateFrom,
        dateTo,
        clinicId,
        receptionistId,
        perPage,
        clearDateFrom,
        clearDateTo,
        clearClinicId,
        clearReceptionistId,
        resetAll,
      ];
}
