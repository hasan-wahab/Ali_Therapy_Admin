part of 'package_attendance_detail_bloc.dart';

abstract class PackageAttendanceDetailEvent extends Equatable {
  const PackageAttendanceDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened — fetch packages + attendance for [patientId].
class PackageAttendanceDetailStarted extends PackageAttendanceDetailEvent {
  const PackageAttendanceDetailStarted(this.patientId);

  final String patientId;

  @override
  List<Object?> get props => [patientId];
}

/// Pull-to-refresh.
class PackageAttendanceDetailRefreshed extends PackageAttendanceDetailEvent {
  const PackageAttendanceDetailRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

/// User tapped a purchased package card.
class PackageAttendanceDetailPackageSelected
    extends PackageAttendanceDetailEvent {
  const PackageAttendanceDetailPackageSelected(this.packageId);

  final String packageId;

  @override
  List<Object?> get props => [packageId];
}
