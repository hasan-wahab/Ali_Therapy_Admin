import '../../../domain/add_experience_domain/entities/add_experience_entity.dart';

// ============================================================
// ADDEXPERIENCE MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class AddExperienceModel extends AddExperienceEntity {
  const AddExperienceModel({required super.id});

  factory AddExperienceModel.fromJson(Map<String, dynamic> json) {
    return AddExperienceModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  AddExperienceEntity toEntity() => AddExperienceEntity(id: id);
}
