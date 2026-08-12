part of 'add_experience_bloc.dart';

abstract class AddExperienceEvent extends Equatable {
  const AddExperienceEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class AddExperienceStarted extends AddExperienceEvent {
  const AddExperienceStarted();
}
