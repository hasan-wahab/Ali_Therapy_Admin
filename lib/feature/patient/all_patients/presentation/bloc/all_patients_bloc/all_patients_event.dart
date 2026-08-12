part of 'all_patients_bloc.dart';

abstract class AllPatientsEvent extends Equatable {
  const AllPatientsEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class AllPatientsStarted extends AllPatientsEvent {
  const AllPatientsStarted();
}
