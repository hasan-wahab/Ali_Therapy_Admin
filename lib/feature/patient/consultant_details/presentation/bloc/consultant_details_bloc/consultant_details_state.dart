part of 'consultant_details_bloc.dart';

abstract class ConsultantDetailsState extends Equatable {
  const ConsultantDetailsState();

  @override
  List<Object?> get props => [];
}

class ConsultantDetailsInitial extends ConsultantDetailsState {
  const ConsultantDetailsInitial();
}

class ConsultantDetailsLoading extends ConsultantDetailsState {
  const ConsultantDetailsLoading();
}

class ConsultantDetailsError extends ConsultantDetailsState {
  final String message;

  const ConsultantDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
