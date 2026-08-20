part of 'patient_dues_history_bloc.dart';

abstract class PatientDuesHistoryState extends Equatable {
  const PatientDuesHistoryState();

  @override
  List<Object?> get props => [];
}

class PatientDuesHistoryInitial extends PatientDuesHistoryState {
  const PatientDuesHistoryInitial();
}

class PatientDuesHistoryLoading extends PatientDuesHistoryState {
  const PatientDuesHistoryLoading();
}

class PatientDuesHistoryLoaded extends PatientDuesHistoryState {
  const PatientDuesHistoryLoaded({
    required this.rows,
    this.isRefreshing = false,
  });

  final List<PatientDuesHistoryEntity> rows;
  final bool isRefreshing;

  PatientDuesHistoryLoaded copyWith({
    List<PatientDuesHistoryEntity>? rows,
    bool? isRefreshing,
  }) {
    return PatientDuesHistoryLoaded(
      rows: rows ?? this.rows,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [rows, isRefreshing];
}

class PatientDuesHistoryError extends PatientDuesHistoryState {
  const PatientDuesHistoryError({
    required this.title,
    required this.message,
    this.rows = const [],
  });

  final String title;
  final String message;
  final List<PatientDuesHistoryEntity> rows;

  @override
  List<Object?> get props => [title, message, rows];
}
