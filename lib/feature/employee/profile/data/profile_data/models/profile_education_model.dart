import '../../../domain/profile_domain/entities/profile_education_entity.dart';
import 'profile_json_helpers.dart';

// ============================================================
// PROFILE EDUCATION MODEL (Data)
// ------------------------------------------------------------
// JSON → ProfileEducationEntity.
// ============================================================

class ProfileEducationModel extends ProfileEducationEntity {
  const ProfileEducationModel({
    required super.id,
    required super.degree,
    required super.university,
    required super.cgpa,
    required super.comments,
  });

  factory ProfileEducationModel.fromJson(Map<String, dynamic> json) {
    return ProfileEducationModel(
      id: ProfileJsonHelpers.text(json['id']),
      degree: ProfileJsonHelpers.text(json['degree']),
      university: ProfileJsonHelpers.text(json['university']),
      cgpa: ProfileJsonHelpers.text(json['cgpa']),
      comments: ProfileJsonHelpers.text(json['comments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'degree': degree,
      'university': university,
      'cgpa': cgpa,
      'comments': comments,
    };
  }

  ProfileEducationEntity toEntity() {
    return ProfileEducationEntity(
      id: id,
      degree: degree,
      university: university,
      cgpa: cgpa,
      comments: comments,
    );
  }
}
