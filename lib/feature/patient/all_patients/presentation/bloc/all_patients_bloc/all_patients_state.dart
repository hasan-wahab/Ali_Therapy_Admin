part of 'all_patients_bloc.dart';

abstract class AllPatientsState extends Equatable {
  const AllPatientsState();

  @override
  List<Object?> get props => [];
}

class AllPatientsInitial extends AllPatientsState {
  const AllPatientsInitial();
}

class AllPatientsLoading extends AllPatientsState {
  const AllPatientsLoading();
}

class AllPatientsError extends AllPatientsState {
  final String message;

  const AllPatientsError(this.message);

  @override
  List<Object?> get props => [message];
}
