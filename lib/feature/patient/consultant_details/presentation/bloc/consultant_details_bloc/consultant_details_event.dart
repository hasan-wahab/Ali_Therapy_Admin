part of 'consultant_details_bloc.dart';

abstract class ConsultantDetailsEvent extends Equatable {
  const ConsultantDetailsEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class ConsultantDetailsStarted extends ConsultantDetailsEvent {
  const ConsultantDetailsStarted();
}
