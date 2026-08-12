part of 'add_document_bloc.dart';

abstract class AddDocumentEvent extends Equatable {
  const AddDocumentEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class AddDocumentStarted extends AddDocumentEvent {
  const AddDocumentStarted();
}
