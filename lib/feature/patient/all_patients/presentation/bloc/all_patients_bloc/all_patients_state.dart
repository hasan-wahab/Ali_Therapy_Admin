part of 'all_patients_bloc.dart';

abstract class AllPatientsState extends Equatable {
  const AllPatientsState();

  @override
  List<Object?> get props => [];
}

class AllPatientsInitial extends AllPatientsState {
  const AllPatientsInitial();
}

class AllPatientsLoading extends AllPatientsState {
  const AllPatientsLoading();
}

/// API success — list ready (supports append / load-more).
class AllPatientsLoaded extends AllPatientsState {
  const AllPatientsLoaded({
    required this.patients,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.isLoadingMore = false,
    this.query = const PatientsListQuery(),
    this.isRefreshingList = false,
  });

  final List<PatientEntity> patients;
  final int currentPage;
  final int lastPage;
  final int total;
  final bool isLoadingMore;
  final PatientsListQuery query;
  final bool isRefreshingList;

  bool get hasMore => currentPage < lastPage;

  AllPatientsLoaded copyWith({
    List<PatientEntity>? patients,
    int? currentPage,
    int? lastPage,
    int? total,
    bool? isLoadingMore,
    PatientsListQuery? query,
    bool? isRefreshingList,
  }) {
    return AllPatientsLoaded(
      patients: patients ?? this.patients,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      total: total ?? this.total,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      query: query ?? this.query,
      isRefreshingList: isRefreshingList ?? this.isRefreshingList,
    );
  }

  @override
  List<Object?> get props => [
        patients,
        currentPage,
        lastPage,
        total,
        isLoadingMore,
        query,
        isRefreshingList,
      ];
}

class AllPatientsError extends AllPatientsState {
  const AllPatientsError({
    required this.title,
    required this.message,
    this.patients = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.query = const PatientsListQuery(),
  });

  final String title;
  final String message;
  final List<PatientEntity> patients;
  final int currentPage;
  final int lastPage;
  final int total;
  final PatientsListQuery query;

  @override
  List<Object?> get props => [
        title,
        message,
        patients,
        currentPage,
        lastPage,
        total,
        query,
      ];
}
