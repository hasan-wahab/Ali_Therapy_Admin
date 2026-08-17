import '../../../domain/profile_domain/entities/profile_experience_entity.dart';
import 'profile_json_helpers.dart';

// ============================================================
// PROFILE EXPERIENCE MODEL (Data)
// ------------------------------------------------------------
// JSON → ProfileExperienceEntity. Supports camelCase + snake_case.
// ============================================================

class ProfileExperienceModel extends ProfileExperienceEntity {
  const ProfileExperienceModel({
    required super.id,
    required super.companyName,
    required super.workingPeriod,
    required super.duties,
    required super.supervisor,
  });

  factory ProfileExperienceModel.fromJson(Map<String, dynamic> json) {
    return ProfileExperienceModel(
      id: ProfileJsonHelpers.text(json['id']),
      companyName: ProfileJsonHelpers.textOf(json, [
        'companyName',
        'company_name',
      ]),
      workingPeriod: ProfileJsonHelpers.textOf(json, [
        'workingPeriod',
        'working_period',
      ]),
      duties: ProfileJsonHelpers.text(json['duties']),
      supervisor: ProfileJsonHelpers.text(json['supervisor']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'workingPeriod': workingPeriod,
      'duties': duties,
      'supervisor': supervisor,
    };
  }

  ProfileExperienceEntity toEntity() {
    return ProfileExperienceEntity(
      id: id,
      companyName: companyName,
      workingPeriod: workingPeriod,
      duties: duties,
      supervisor: supervisor,
    );
  }
}
