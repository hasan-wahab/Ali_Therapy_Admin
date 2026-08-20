part of 'package_attendance_detail_bloc.dart';

abstract class PackageAttendanceDetailState extends Equatable {
  const PackageAttendanceDetailState();

  @override
  List<Object?> get props => [];
}

class PackageAttendanceDetailInitial extends PackageAttendanceDetailState {
  const PackageAttendanceDetailInitial();
}

class PackageAttendanceDetailLoading extends PackageAttendanceDetailState {
  const PackageAttendanceDetailLoading();
}

class PackageAttendanceDetailLoaded extends PackageAttendanceDetailState {
  const PackageAttendanceDetailLoaded({
    required this.detail,
    required this.selectedPackageId,
    this.isRefreshing = false,
  });

  final PackageAttendanceDetailEntity detail;
  final String selectedPackageId;
  final bool isRefreshing;

  PackageAttendanceDetailLoaded copyWith({
    PackageAttendanceDetailEntity? detail,
    String? selectedPackageId,
    bool? isRefreshing,
  }) {
    return PackageAttendanceDetailLoaded(
      detail: detail ?? this.detail,
      selectedPackageId: selectedPackageId ?? this.selectedPackageId,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [detail, selectedPackageId, isRefreshing];
}

class PackageAttendanceDetailError extends PackageAttendanceDetailState {
  const PackageAttendanceDetailError({
    required this.title,
    required this.message,
    this.detail,
    this.selectedPackageId = '',
  });

  final String title;
  final String message;
  final PackageAttendanceDetailEntity? detail;
  final String selectedPackageId;

  @override
  List<Object?> get props => [title, message, detail, selectedPackageId];
}
