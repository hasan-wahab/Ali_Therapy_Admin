import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/entities/package_attendance_detail_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/usecases/get_package_attendance_detail_usecase.dart';

part 'package_attendance_detail_event.dart';
part 'package_attendance_detail_state.dart';

// ============================================================
// PACKAGE ATTENDANCE DETAIL BLOC
// ------------------------------------------------------------
// Loads packages + session history for one patient.
// UI → Event → UseCase → State → UI
// ============================================================

class PackageAttendanceDetailBloc
    extends Bloc<PackageAttendanceDetailEvent, PackageAttendanceDetailState> {
  PackageAttendanceDetailBloc({
    required this.getPackageAttendanceDetailUseCase,
  }) : super(const PackageAttendanceDetailInitial()) {
    on<PackageAttendanceDetailStarted>(_onStarted);
    on<PackageAttendanceDetailRefreshed>(_onRefreshed);
    on<PackageAttendanceDetailPackageSelected>(_onPackageSelected);
  }

  final GetPackageAttendanceDetailUseCase getPackageAttendanceDetailUseCase;

  String _patientId = '';
  String _selectedPackageId = '';

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(PackageAttendanceDetailRefreshed(completer: completer));
    return completer.future;
  }

  Future<void> _onStarted(
    PackageAttendanceDetailStarted event,
    Emitter<PackageAttendanceDetailState> emit,
  ) async {
    _patientId = event.patientId.trim();
    _selectedPackageId = '';
    emit(const PackageAttendanceDetailLoading());
    await _load(emit);
  }

  Future<void> _onRefreshed(
    PackageAttendanceDetailRefreshed event,
    Emitter<PackageAttendanceDetailState> emit,
  ) async {
    try {
      final current = state;
      PackageAttendanceDetailEntity? keep;
      if (current is PackageAttendanceDetailLoaded) {
        keep = current.detail;
        emit(current.copyWith(isRefreshing: true));
      } else if (current is PackageAttendanceDetailError) {
        keep = current.detail;
      }
      await _load(emit, keepOnError: keep);
    } finally {
      if (!event.completer.isCompleted) event.completer.complete();
    }
  }

  void _onPackageSelected(
    PackageAttendanceDetailPackageSelected event,
    Emitter<PackageAttendanceDetailState> emit,
  ) {
    final current = state;
    if (current is! PackageAttendanceDetailLoaded) return;
    _selectedPackageId = event.packageId;
    emit(current.copyWith(selectedPackageId: _selectedPackageId));
  }

  Future<void> _load(
    Emitter<PackageAttendanceDetailState> emit, {
    PackageAttendanceDetailEntity? keepOnError,
  }) async {
    if (_patientId.isEmpty) {
      emit(const PackageAttendanceDetailError(
        title: 'Missing patient',
        message: 'Could not load package attendance for this patient.',
      ));
      return;
    }

    final result = await getPackageAttendanceDetailUseCase(_patientId);

    result.when(
      success: (detail) {
        final stillThere = detail.packages.any(
          (package) => package.id == _selectedPackageId,
        );
        if (!stillThere) {
          _selectedPackageId = detail.featuredPackage?.id ?? '';
        }
        emit(PackageAttendanceDetailLoaded(
          detail: detail,
          selectedPackageId: _selectedPackageId,
        ));
      },
      failure: (failure) {
        emit(PackageAttendanceDetailError(
          title: failure.title,
          message: failure.message,
          detail: keepOnError,
          selectedPackageId: _selectedPackageId,
        ));
        if (keepOnError != null) {
          emit(PackageAttendanceDetailLoaded(
            detail: keepOnError,
            selectedPackageId: _selectedPackageId,
          ));
        }
      },
    );
  }
}
