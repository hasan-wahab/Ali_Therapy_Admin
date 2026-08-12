import '../../../domain/total_visits_domain/entities/total_visits_entity.dart';

// ============================================================
// TOTALVISITS MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class TotalVisitsModel extends TotalVisitsEntity {
  const TotalVisitsModel({required super.id});

  factory TotalVisitsModel.fromJson(Map<String, dynamic> json) {
    return TotalVisitsModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  TotalVisitsEntity toEntity() => TotalVisitsEntity(id: id);
}
