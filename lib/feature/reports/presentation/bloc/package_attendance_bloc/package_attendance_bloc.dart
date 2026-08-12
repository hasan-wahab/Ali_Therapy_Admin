import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package_attendance_event.dart';
part 'package_attendance_state.dart';

// ============================================================
// PACKAGEATTENDANCE BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class PackageAttendanceBloc extends Bloc<PackageAttendanceEvent, PackageAttendanceState> {
  PackageAttendanceBloc() : super(const PackageAttendanceInitial()) {
    on<PackageAttendanceStarted>(_onStarted);
  }

  Future<void> _onStarted(
    PackageAttendanceStarted event,
    Emitter<PackageAttendanceState> emit,
  ) async {
    // TODO: call GetPackageAttendanceUseCase when API is ready.
    emit(const PackageAttendanceInitial());
  }
}
