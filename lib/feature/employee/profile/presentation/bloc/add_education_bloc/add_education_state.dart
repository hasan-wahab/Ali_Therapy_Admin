part of 'add_education_bloc.dart';

abstract class AddEducationState extends Equatable {
  const AddEducationState();

  @override
  List<Object?> get props => [];
}

class AddEducationInitial extends AddEducationState {
  const AddEducationInitial();
}

class AddEducationLoading extends AddEducationState {
  const AddEducationLoading();
}

class AddEducationError extends AddEducationState {
  final String message;

  const AddEducationError(this.message);

  @override
  List<Object?> get props => [message];
}
