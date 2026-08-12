import '../../../domain/consultant_details_domain/entities/consultant_details_entity.dart';

// ============================================================
// CONSULTANTDETAILS MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class ConsultantDetailsModel extends ConsultantDetailsEntity {
  const ConsultantDetailsModel({required super.id});

  factory ConsultantDetailsModel.fromJson(Map<String, dynamic> json) {
    return ConsultantDetailsModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  ConsultantDetailsEntity toEntity() => ConsultantDetailsEntity(id: id);
}
