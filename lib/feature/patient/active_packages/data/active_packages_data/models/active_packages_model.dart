import '../../../domain/active_packages_domain/entities/active_packages_entity.dart';

// ============================================================
// ACTIVEPACKAGES MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class ActivePackagesModel extends ActivePackagesEntity {
  const ActivePackagesModel({required super.id});

  factory ActivePackagesModel.fromJson(Map<String, dynamic> json) {
    return ActivePackagesModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  ActivePackagesEntity toEntity() => ActivePackagesEntity(id: id);
}
