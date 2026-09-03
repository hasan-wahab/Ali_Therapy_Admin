import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/patient_detail_domain/entities/patient_detail_entity.dart';
import '../../../domain/patient_detail_domain/usecases/get_patient_detail_usecase.dart';

part 'patient_detail_event.dart';
part 'patient_detail_state.dart';

// ============================================================
// PATIENT DETAIL BLOC
// ------------------------------------------------------------
// Started(patientId) → GET patient/{id}/full-view
// Pull refresh → same API; AppBar underline shows loading.
// ============================================================

class PatientDetailBloc extends Bloc<PatientDetailEvent, PatientDetailState> {
  PatientDetailBloc({required this.getPatientDetailUseCase})
    : super(const PatientDetailInitial()) {
    on<PatientDetailStarted>(_onStarted);
    on<PatientDetailRefreshed>(_onRefreshed);
  }

  final GetPatientDetailUseCase getPatientDetailUseCase;

  String _patientId = '';

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(PatientDetailRefreshed(completer: completer));
    return completer.future;
  }

  Future<void> _onStarted(
    PatientDetailStarted event,
    Emitter<PatientDetailState> emit,
  ) async {
    _patientId = event.patientId.trim();
    if (event.seed != null) {
      emit(PatientDetailLoaded(event.seed!));
      return;
    }
    emit(const PatientDetailLoading());
    await _load(emit);
  }

  Future<void> _onRefreshed(
    PatientDetailRefreshed event,
    Emitter<PatientDetailState> emit,
  ) async {
    try {
      final current = state;
      PatientDetailEntity? keep;
      if (current is PatientDetailLoaded) {
        keep = current.detail;
        emit(current.copyWith(isRefreshing: true));
      } else if (current is PatientDetailError) {
        keep = current.detail;
        emit(const PatientDetailLoading());
      } else {
        emit(const PatientDetailLoading());
      }
      await _load(emit, keepOnError: keep);
    } finally {
      if (!event.completer.isCompleted) {
        event.completer.complete();
      }
    }
  }

  Future<void> _load(
    Emitter<PatientDetailState> emit, {
    PatientDetailEntity? keepOnError,
  }) async {
    final patientId = _patientId.trim();
    if (patientId.isEmpty || patientId == '_') {
      emit(
        PatientDetailError(
          title: 'Missing Id',
          message: 'Patient id is missing. Open detail from View again.',
          detail: keepOnError,
        ),
      );
      return;
    }

    final result = await getPatientDetailUseCase(
      GetPatientDetailParams(patientId: patientId),
    );

    result.when(
      success: (detail) => emit(PatientDetailLoaded(detail)),
      failure: (failure) => emit(
        PatientDetailError(
          title: failure.title,
          message: failure.message,
          detail: keepOnError,
        ),
      ),
    );
  }
}
