import '../../../domain/login_domain/entities/clinic_entity.dart';
import 'login_json_helpers.dart';

// ============================================================
// CLINIC MODEL (Data)
// ------------------------------------------------------------
// JSON → ClinicEntity. Null fields become "_".
// ============================================================

class ClinicModel extends ClinicEntity {
  const ClinicModel({
    required super.id,
    required super.name,
    required super.location,
    required super.description,
    required super.colourCode,
    required super.createdBy,
    required super.updatedBy,
    required super.deletedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      id: LoginJsonHelpers.text(json['id']),
      name: LoginJsonHelpers.text(json['name']),
      location: LoginJsonHelpers.text(json['location']),
      description: LoginJsonHelpers.text(json['description']),
      colourCode: LoginJsonHelpers.text(json['colour_code']),
      createdBy: LoginJsonHelpers.text(json['created_by']),
      updatedBy: LoginJsonHelpers.text(json['updated_by']),
      deletedAt: LoginJsonHelpers.text(json['deleted_at']),
      createdAt: LoginJsonHelpers.text(json['created_at']),
      updatedAt: LoginJsonHelpers.text(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'colour_code': colourCode,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  ClinicEntity toEntity() {
    return ClinicEntity(
      id: id,
      name: name,
      location: location,
      description: description,
      colourCode: colourCode,
      createdBy: createdBy,
      updatedBy: updatedBy,
      deletedAt: deletedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
