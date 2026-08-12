import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'consultant_details_event.dart';
part 'consultant_details_state.dart';

// ============================================================
// CONSULTANTDETAILS BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class ConsultantDetailsBloc extends Bloc<ConsultantDetailsEvent, ConsultantDetailsState> {
  ConsultantDetailsBloc() : super(const ConsultantDetailsInitial()) {
    on<ConsultantDetailsStarted>(_onStarted);
  }

  Future<void> _onStarted(
    ConsultantDetailsStarted event,
    Emitter<ConsultantDetailsState> emit,
  ) async {
    // TODO: call GetConsultantDetailsUseCase when API is ready.
    emit(const ConsultantDetailsInitial());
  }
}
