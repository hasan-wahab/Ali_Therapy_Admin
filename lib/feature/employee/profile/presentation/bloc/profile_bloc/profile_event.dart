part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class ProfileStarted extends ProfileEvent {
  const ProfileStarted();
}
