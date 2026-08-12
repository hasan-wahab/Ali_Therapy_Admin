import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'invoices_event.dart';
part 'invoices_state.dart';

// ============================================================
// INVOICES BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class InvoicesBloc extends Bloc<InvoicesEvent, InvoicesState> {
  InvoicesBloc() : super(const InvoicesInitial()) {
    on<InvoicesStarted>(_onStarted);
  }

  Future<void> _onStarted(
    InvoicesStarted event,
    Emitter<InvoicesState> emit,
  ) async {
    // TODO: call GetInvoicesUseCase when API is ready.
    emit(const InvoicesInitial());
  }
}
