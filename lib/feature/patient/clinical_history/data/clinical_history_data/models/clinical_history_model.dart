import '../../../domain/clinical_history_domain/entities/clinical_history_entity.dart';

// ============================================================
// CLINICALHISTORY MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class ClinicalHistoryModel extends ClinicalHistoryEntity {
  const ClinicalHistoryModel({required super.id});

  factory ClinicalHistoryModel.fromJson(Map<String, dynamic> json) {
    return ClinicalHistoryModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  ClinicalHistoryEntity toEntity() => ClinicalHistoryEntity(id: id);
}
