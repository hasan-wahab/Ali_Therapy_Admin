import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'assistant_manager_report_event.dart';
part 'assistant_manager_report_state.dart';

// ============================================================
// ASSISTANTMANAGERREPORT BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class AssistantManagerReportBloc extends Bloc<AssistantManagerReportEvent, AssistantManagerReportState> {
  AssistantManagerReportBloc() : super(const AssistantManagerReportInitial()) {
    on<AssistantManagerReportStarted>(_onStarted);
  }

  Future<void> _onStarted(
    AssistantManagerReportStarted event,
    Emitter<AssistantManagerReportState> emit,
  ) async {
    // TODO: call GetAssistantManagerReportUseCase when API is ready.
    emit(const AssistantManagerReportInitial());
  }
}
