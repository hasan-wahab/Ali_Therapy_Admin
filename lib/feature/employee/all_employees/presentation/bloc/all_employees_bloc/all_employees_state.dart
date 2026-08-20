part of 'all_employees_bloc.dart';

// Sentinel used by copyWith to distinguish "not passed" from "null".
const Object _keep = Object();

abstract class AllEmployeesState extends Equatable {
  const AllEmployeesState();

  @override
  List<Object?> get props => [];
}

class AllEmployeesInitial extends AllEmployeesState {
  const AllEmployeesInitial();
}

class AllEmployeesLoading extends AllEmployeesState {
  const AllEmployeesLoading();
}

/// API success — list ready (supports append / load-more).
class AllEmployeesLoaded extends AllEmployeesState {
  final List<EmployeeEntity> employees;
  final int currentPage;
  final int lastPage;
  final int total;
  final bool isLoadingMore;
  final EmployeesFiltersEntity filters;
  final EmployeesListQuery query;

  /// True while a filter/search reload is in progress (list may stay visible).
  final bool isRefreshingList;

  /// Employee id currently being toggled (null = none in progress).
  final String? togglingEmployeeId;

  /// Employee id currently being terminated (null = none in progress).
  final String? terminatingEmployeeId;

  /// Employee id whose password is being changed (null = none in progress).
  final String? changingPasswordEmployeeId;

  /// Employee id currently assigning a device ID (null = none in progress).
  final String? assigningDeviceEmployeeId;

  /// Employee id currently assigning a biometric ID (null = none in progress).
  final String? assigningBiometricEmployeeId;

  /// One-shot success text after terminate / change password / assign IDs.
  final String? successMessage;

  const AllEmployeesLoaded({
    required this.employees,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.isLoadingMore = false,
    this.filters = const EmployeesFiltersEntity.empty(),
    this.query = const EmployeesListQuery(),
    this.isRefreshingList = false,
    this.togglingEmployeeId,
    this.terminatingEmployeeId,
    this.changingPasswordEmployeeId,
    this.assigningDeviceEmployeeId,
    this.assigningBiometricEmployeeId,
    this.successMessage,
  });

  bool get hasMore => currentPage < lastPage;

  AllEmployeesLoaded copyWith({
    List<EmployeeEntity>? employees,
    int? currentPage,
    int? lastPage,
    int? total,
    bool? isLoadingMore,
    EmployeesFiltersEntity? filters,
    EmployeesListQuery? query,
    bool? isRefreshingList,
    // Pass null explicitly to clear togglingEmployeeId.
    Object? togglingEmployeeId = _keep,
    Object? terminatingEmployeeId = _keep,
    Object? changingPasswordEmployeeId = _keep,
    Object? assigningDeviceEmployeeId = _keep,
    Object? assigningBiometricEmployeeId = _keep,
    Object? successMessage = _keep,
  }) {
    return AllEmployeesLoaded(
      employees: employees ?? this.employees,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      total: total ?? this.total,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      filters: filters ?? this.filters,
      query: query ?? this.query,
      isRefreshingList: isRefreshingList ?? this.isRefreshingList,
      togglingEmployeeId: togglingEmployeeId == _keep
          ? this.togglingEmployeeId
          : togglingEmployeeId as String?,
      terminatingEmployeeId: terminatingEmployeeId == _keep
          ? this.terminatingEmployeeId
          : terminatingEmployeeId as String?,
      changingPasswordEmployeeId: changingPasswordEmployeeId == _keep
          ? this.changingPasswordEmployeeId
          : changingPasswordEmployeeId as String?,
      assigningDeviceEmployeeId: assigningDeviceEmployeeId == _keep
          ? this.assigningDeviceEmployeeId
          : assigningDeviceEmployeeId as String?,
      assigningBiometricEmployeeId: assigningBiometricEmployeeId == _keep
          ? this.assigningBiometricEmployeeId
          : assigningBiometricEmployeeId as String?,
      successMessage: successMessage == _keep
          ? this.successMessage
          : successMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
        employees,
        currentPage,
        lastPage,
        total,
        isLoadingMore,
        filters,
        query,
        isRefreshingList,
        togglingEmployeeId,
        terminatingEmployeeId,
        changingPasswordEmployeeId,
        assigningDeviceEmployeeId,
        assigningBiometricEmployeeId,
        successMessage,
      ];
}

class AllEmployeesError extends AllEmployeesState {
  final String title;
  final String message;

  /// Keep showing this list when refresh / load-more fails.
  final List<EmployeeEntity> employees;
  final int currentPage;
  final int lastPage;
  final int total;
  final EmployeesFiltersEntity filters;
  final EmployeesListQuery query;

  const AllEmployeesError({
    required this.title,
    required this.message,
    this.employees = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.filters = const EmployeesFiltersEntity.empty(),
    this.query = const EmployeesListQuery(),
  });

  @override
  List<Object?> get props => [
        title,
        message,
        employees,
        currentPage,
        lastPage,
        total,
        filters,
        query,
      ];
}
