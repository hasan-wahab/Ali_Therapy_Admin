part of 'package_attendance_bloc.dart';

abstract class PackageAttendanceEvent extends Equatable {
  const PackageAttendanceEvent();

  @override
  List<Object?> get props => [];
}

class PackageAttendanceStarted extends PackageAttendanceEvent {
  const PackageAttendanceStarted();
}

class PackageAttendanceRefreshed extends PackageAttendanceEvent {
  const PackageAttendanceRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

class PackageAttendanceLoadMore extends PackageAttendanceEvent {
  const PackageAttendanceLoadMore();
}

class PackageAttendanceSearchChanged extends PackageAttendanceEvent {
  const PackageAttendanceSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class PackageAttendanceSearchSubmitted extends PackageAttendanceEvent {
  const PackageAttendanceSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class PackageAttendanceFiltersApplied extends PackageAttendanceEvent {
  const PackageAttendanceFiltersApplied({
    this.clinicId,
    this.gender,
    this.therapistId,
    this.perPage,
    this.clearClinicId = false,
    this.clearGender = false,
    this.clearTherapistId = false,
    this.resetAll = false,
  });

  final int? clinicId;
  final String? gender;
  final int? therapistId;
  final int? perPage;

  final bool clearClinicId;
  final bool clearGender;
  final bool clearTherapistId;
  final bool resetAll;

  @override
  List<Object?> get props => [
        clinicId,
        gender,
        therapistId,
        perPage,
        clearClinicId,
        clearGender,
        clearTherapistId,
        resetAll,
      ];
}
