import '../../../domain/patient_detail_domain/entities/patient_detail_visit_entity.dart';
import 'patient_detail_json_helpers.dart';

// ============================================================
// PATIENT DETAIL VISIT MODEL
// ------------------------------------------------------------
// Parses one item from data.visits
// ============================================================

class PatientDetailVisitModel extends PatientDetailVisitEntity {
  const PatientDetailVisitModel({
    super.id,
    super.date,
    super.type,
    super.doctor,
    super.stage,
    super.amount,
  });

  factory PatientDetailVisitModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailVisitModel(
      id: PatientDetailJsonHelpers.text(json['id']),
      date: PatientDetailJsonHelpers.text(json['date']),
      type: PatientDetailJsonHelpers.text(json['type']),
      doctor: PatientDetailJsonHelpers.text(json['doctor']),
      stage: PatientDetailJsonHelpers.text(json['stage']),
      amount: PatientDetailJsonHelpers.decimal(json['amount']),
    );
  }

  static List<PatientDetailVisitModel> listFromJson(dynamic raw) {
    return PatientDetailJsonHelpers.mapList(
      raw,
      PatientDetailVisitModel.fromJson,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'type': type,
      'doctor': doctor,
      'stage': stage,
      'amount': amount,
    };
  }

  PatientDetailVisitEntity toEntity() {
    return PatientDetailVisitEntity(
      id: id,
      date: date,
      type: type,
      doctor: doctor,
      stage: stage,
      amount: amount,
    );
  }
}
