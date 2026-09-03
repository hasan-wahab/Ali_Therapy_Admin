part of 'patient_detail_bloc.dart';

abstract class PatientDetailState extends Equatable {
  const PatientDetailState();

  @override
  List<Object?> get props => [];
}

class PatientDetailInitial extends PatientDetailState {
  const PatientDetailInitial();
}

class PatientDetailLoading extends PatientDetailState {
  const PatientDetailLoading();
}

class PatientDetailLoaded extends PatientDetailState {
  const PatientDetailLoaded(
    this.detail, {
    this.isRefreshing = false,
  });

  final PatientDetailEntity detail;
  final bool isRefreshing;

  PatientDetailLoaded copyWith({
    PatientDetailEntity? detail,
    bool? isRefreshing,
  }) {
    return PatientDetailLoaded(
      detail ?? this.detail,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [detail, isRefreshing];
}

class PatientDetailError extends PatientDetailState {
  const PatientDetailError({
    required this.title,
    required this.message,
    this.detail,
  });

  final String title;
  final String message;
  final PatientDetailEntity? detail;

  @override
  List<Object?> get props => [title, message, detail];
}
