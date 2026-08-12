import '../../../domain/profile_domain/entities/profile_entity.dart';

// ============================================================
// PROFILE MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class ProfileModel extends ProfileEntity {
  const ProfileModel({required super.id});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  ProfileEntity toEntity() => ProfileEntity(id: id);
}
