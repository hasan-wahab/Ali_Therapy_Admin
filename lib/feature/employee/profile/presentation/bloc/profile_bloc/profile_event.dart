part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Load profile for the employee id from All Employees → View.
class ProfileStarted extends ProfileEvent {
  const ProfileStarted({required this.employeeId});

  final String employeeId;

  @override
  List<Object?> get props => [employeeId];
}
