import '../../../domain/profile_domain/entities/profile_document_entity.dart';
import 'profile_json_helpers.dart';

// ============================================================
// PROFILE DOCUMENT MODEL (Data)
// ------------------------------------------------------------
// JSON → ProfileDocumentEntity. Supports camelCase + snake_case.
// ============================================================

class ProfileDocumentModel extends ProfileDocumentEntity {
  const ProfileDocumentModel({
    required super.id,
    required super.docTitle,
    required super.docDescription,
    required super.docFile,
    required super.docExpiry,
  });

  factory ProfileDocumentModel.fromJson(Map<String, dynamic> json) {
    return ProfileDocumentModel(
      id: ProfileJsonHelpers.text(json['id']),
      docTitle: ProfileJsonHelpers.textOf(json, ['docTitle', 'doc_title']),
      docDescription: ProfileJsonHelpers.textOf(json, [
        'docDescription',
        'doc_description',
      ]),
      docFile: ProfileJsonHelpers.textOf(json, ['docFile', 'doc_file']),
      docExpiry: ProfileJsonHelpers.textOf(json, ['docExpiry', 'doc_expiry']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'docTitle': docTitle,
      'docDescription': docDescription,
      'docFile': docFile,
      'docExpiry': docExpiry,
    };
  }

  ProfileDocumentEntity toEntity() {
    return ProfileDocumentEntity(
      id: id,
      docTitle: docTitle,
      docDescription: docDescription,
      docFile: docFile,
      docExpiry: docExpiry,
    );
  }
}
