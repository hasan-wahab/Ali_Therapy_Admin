part of 'package_attendance_bloc.dart';

abstract class PackageAttendanceEvent extends Equatable {
  const PackageAttendanceEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class PackageAttendanceStarted extends PackageAttendanceEvent {
  const PackageAttendanceStarted();
}
