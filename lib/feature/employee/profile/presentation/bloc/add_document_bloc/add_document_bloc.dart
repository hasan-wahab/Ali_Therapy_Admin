import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_document_event.dart';
part 'add_document_state.dart';

// ============================================================
// ADDDOCUMENT BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class AddDocumentBloc extends Bloc<AddDocumentEvent, AddDocumentState> {
  AddDocumentBloc() : super(const AddDocumentInitial()) {
    on<AddDocumentStarted>(_onStarted);
  }

  Future<void> _onStarted(
    AddDocumentStarted event,
    Emitter<AddDocumentState> emit,
  ) async {
    // TODO: call GetAddDocumentUseCase when API is ready.
    emit(const AddDocumentInitial());
  }
}
