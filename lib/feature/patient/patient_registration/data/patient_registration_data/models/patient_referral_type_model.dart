import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/models/patient_form_json_helpers.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_referral_type_entity.dart';

// ============================================================
// PATIENT REFERRAL TYPE MODEL (Data)
// ------------------------------------------------------------
// JSON → PatientReferralTypeEntity
// ============================================================

class PatientReferralTypeModel extends PatientReferralTypeEntity {
  const PatientReferralTypeModel({
    required super.key,
    required super.label,
    super.needsField,
    super.needsPanel,
    super.needsSocial,
    super.needsText,
  });

  factory PatientReferralTypeModel.fromJson(Map<String, dynamic> json) {
    return PatientReferralTypeModel(
      key: PatientFormJsonHelpers.text(json['key']),
      label: PatientFormJsonHelpers.titleCase(
        PatientFormJsonHelpers.text(json['label']),
      ),
      needsField: PatientFormJsonHelpers.flag(json['needs_field']),
      needsPanel: PatientFormJsonHelpers.flag(json['needs_panel']),
      needsSocial: PatientFormJsonHelpers.flag(json['needs_social']),
      needsText: PatientFormJsonHelpers.flag(json['needs_text']),
    );
  }

  static List<PatientReferralTypeModel> listFromJson(dynamic raw) {
    final result = <PatientReferralTypeModel>[];
    for (final item in PatientFormJsonHelpers.listOrEmpty(raw)) {
      final map = PatientFormJsonHelpers.mapOrNull(item);
      if (map == null) continue;
      final model = PatientReferralTypeModel.fromJson(map);
      if (model.key.isEmpty && model.label.isEmpty) continue;
      result.add(model);
    }
    return result;
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'label': label,
      'needs_field': needsField,
      'needs_panel': needsPanel,
      'needs_social': needsSocial,
      'needs_text': needsText,
    };
  }

  PatientReferralTypeEntity toEntity() {
    return PatientReferralTypeEntity(
      key: key,
      label: label,
      needsField: needsField,
      needsPanel: needsPanel,
      needsSocial: needsSocial,
      needsText: needsText,
    );
  }
}
