part of 'add_document_bloc.dart';

abstract class AddDocumentState extends Equatable {
  const AddDocumentState();

  @override
  List<Object?> get props => [];
}

class AddDocumentInitial extends AddDocumentState {
  const AddDocumentInitial();
}

class AddDocumentLoading extends AddDocumentState {
  const AddDocumentLoading();
}

class AddDocumentError extends AddDocumentState {
  final String message;

  const AddDocumentError(this.message);

  @override
  List<Object?> get props => [message];
}
