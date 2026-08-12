import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'insurance_panel_report_event.dart';
part 'insurance_panel_report_state.dart';

// ============================================================
// INSURANCEPANELREPORT BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class InsurancePanelReportBloc extends Bloc<InsurancePanelReportEvent, InsurancePanelReportState> {
  InsurancePanelReportBloc() : super(const InsurancePanelReportInitial()) {
    on<InsurancePanelReportStarted>(_onStarted);
  }

  Future<void> _onStarted(
    InsurancePanelReportStarted event,
    Emitter<InsurancePanelReportState> emit,
  ) async {
    // TODO: call GetInsurancePanelReportUseCase when API is ready.
    emit(const InsurancePanelReportInitial());
  }
}
