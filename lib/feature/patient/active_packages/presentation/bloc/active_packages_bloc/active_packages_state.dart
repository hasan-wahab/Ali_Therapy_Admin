part of 'active_packages_bloc.dart';

abstract class ActivePackagesState extends Equatable {
  const ActivePackagesState();

  @override
  List<Object?> get props => [];
}

class ActivePackagesInitial extends ActivePackagesState {
  const ActivePackagesInitial();
}

class ActivePackagesLoading extends ActivePackagesState {
  const ActivePackagesLoading();
}

class ActivePackagesError extends ActivePackagesState {
  final String message;

  const ActivePackagesError(this.message);

  @override
  List<Object?> get props => [message];
}
