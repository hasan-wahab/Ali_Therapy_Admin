import '../../../domain/add_education_domain/entities/add_education_entity.dart';

// ============================================================
// ADDEDUCATION MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class AddEducationModel extends AddEducationEntity {
  const AddEducationModel({required super.id});

  factory AddEducationModel.fromJson(Map<String, dynamic> json) {
    return AddEducationModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  AddEducationEntity toEntity() => AddEducationEntity(id: id);
}
