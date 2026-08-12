part of 'add_experience_bloc.dart';

abstract class AddExperienceState extends Equatable {
  const AddExperienceState();

  @override
  List<Object?> get props => [];
}

class AddExperienceInitial extends AddExperienceState {
  const AddExperienceInitial();
}

class AddExperienceLoading extends AddExperienceState {
  const AddExperienceLoading();
}

class AddExperienceError extends AddExperienceState {
  final String message;

  const AddExperienceError(this.message);

  @override
  List<Object?> get props => [message];
}
