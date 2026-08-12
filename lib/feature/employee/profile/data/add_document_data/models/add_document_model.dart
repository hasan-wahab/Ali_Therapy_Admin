import '../../../domain/add_document_domain/entities/add_document_entity.dart';

// ============================================================
// ADDDOCUMENT MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class AddDocumentModel extends AddDocumentEntity {
  const AddDocumentModel({required super.id});

  factory AddDocumentModel.fromJson(Map<String, dynamic> json) {
    return AddDocumentModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  AddDocumentEntity toEntity() => AddDocumentEntity(id: id);
}
