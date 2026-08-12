import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_activity_report_event.dart';
part 'user_activity_report_state.dart';

// ============================================================
// USERACTIVITYREPORT BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class UserActivityReportBloc extends Bloc<UserActivityReportEvent, UserActivityReportState> {
  UserActivityReportBloc() : super(const UserActivityReportInitial()) {
    on<UserActivityReportStarted>(_onStarted);
  }

  Future<void> _onStarted(
    UserActivityReportStarted event,
    Emitter<UserActivityReportState> emit,
  ) async {
    // TODO: call GetUserActivityReportUseCase when API is ready.
    emit(const UserActivityReportInitial());
  }
}
