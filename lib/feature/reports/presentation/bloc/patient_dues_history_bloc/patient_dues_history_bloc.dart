import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_history_domain/entities/patient_dues_history_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_history_domain/usecases/get_patient_dues_history_usecase.dart';

part 'patient_dues_history_event.dart';
part 'patient_dues_history_state.dart';

// ============================================================
// PATIENT DUES HISTORY BLOC
// ------------------------------------------------------------
// Loads invoice rows for one patient.
// UI → Event → UseCase → State → UI
// ============================================================

class PatientDuesHistoryBloc
    extends Bloc<PatientDuesHistoryEvent, PatientDuesHistoryState> {
  PatientDuesHistoryBloc({
    required this.getPatientDuesHistoryUseCase,
  }) : super(const PatientDuesHistoryInitial()) {
    on<PatientDuesHistoryStarted>(_onStarted);
    on<PatientDuesHistoryRefreshed>(_onRefreshed);
  }

  final GetPatientDuesHistoryUseCase getPatientDuesHistoryUseCase;

  String _patientId = '';

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(PatientDuesHistoryRefreshed(completer: completer));
    return completer.future;
  }

  Future<void> _onStarted(
    PatientDuesHistoryStarted event,
    Emitter<PatientDuesHistoryState> emit,
  ) async {
    _patientId = event.patientId.trim();
    emit(const PatientDuesHistoryLoading());
    await _load(emit, keepOnError: const []);
  }

  Future<void> _onRefreshed(
    PatientDuesHistoryRefreshed event,
    Emitter<PatientDuesHistoryState> emit,
  ) async {
    try {
      final current = state;
      List<PatientDuesHistoryEntity> keep = const [];
      if (current is PatientDuesHistoryLoaded) {
        keep = current.rows;
        emit(current.copyWith(isRefreshing: true));
      } else if (current is PatientDuesHistoryError) {
        keep = current.rows;
      }
      await _load(emit, keepOnError: keep);
    } finally {
      if (!event.completer.isCompleted) event.completer.complete();
    }
  }

  Future<void> _load(
    Emitter<PatientDuesHistoryState> emit, {
    required List<PatientDuesHistoryEntity> keepOnError,
  }) async {
    if (_patientId.isEmpty) {
      emit(const PatientDuesHistoryError(
        title: 'Missing patient',
        message: 'Could not load dues history for this patient.',
      ));
      return;
    }

    final result = await getPatientDuesHistoryUseCase(_patientId);

    result.when(
      success: (rows) {
        emit(PatientDuesHistoryLoaded(rows: rows));
      },
      failure: (failure) {
        emit(PatientDuesHistoryError(
          title: failure.title,
          message: failure.message,
          rows: keepOnError,
        ));
        if (keepOnError.isNotEmpty) {
          emit(PatientDuesHistoryLoaded(rows: keepOnError));
        }
      },
    );
  }
}
