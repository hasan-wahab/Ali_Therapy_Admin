part of 'active_packages_bloc.dart';

abstract class ActivePackagesEvent extends Equatable {
  const ActivePackagesEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class ActivePackagesStarted extends ActivePackagesEvent {
  const ActivePackagesStarted();
}
