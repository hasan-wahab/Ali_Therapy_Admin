part of 'add_education_bloc.dart';

abstract class AddEducationEvent extends Equatable {
  const AddEducationEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class AddEducationStarted extends AddEducationEvent {
  const AddEducationStarted();
}
