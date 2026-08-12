part of 'package_attendance_bloc.dart';

abstract class PackageAttendanceState extends Equatable {
  const PackageAttendanceState();

  @override
  List<Object?> get props => [];
}

class PackageAttendanceInitial extends PackageAttendanceState {
  const PackageAttendanceInitial();
}

class PackageAttendanceLoading extends PackageAttendanceState {
  const PackageAttendanceLoading();
}

class PackageAttendanceError extends PackageAttendanceState {
  final String message;

  const PackageAttendanceError(this.message);

  @override
  List<Object?> get props => [message];
}
