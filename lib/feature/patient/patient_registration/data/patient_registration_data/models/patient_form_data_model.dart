import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/models/patient_form_json_helpers.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/models/patient_referral_type_model.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_form_data_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_referral_type_entity.dart';

// ============================================================
// PATIENT FORM DATA MODEL (Data)
// ------------------------------------------------------------
// Parses GET patients/form-data:
// { success, data: { cities, languages, referral_types, ... } }
// ============================================================

class PatientFormDataModel extends PatientFormDataEntity {
  const PatientFormDataModel({
    required super.cities,
    required super.languages,
    required super.maritalStatuses,
    required super.genders,
    required super.bloodGroups,
    required super.referralTypes,
    required super.referralFields,
    required super.insurancePanels,
    required super.socialMediaPlatforms,
  });

  factory PatientFormDataModel.fromJson(Map<String, dynamic> json) {
    return PatientFormDataModel(
      cities: PatientFormJsonHelpers.stringList(json['cities']),
      languages: PatientFormJsonHelpers.stringList(json['languages']),
      maritalStatuses: PatientFormJsonHelpers.stringList(
        json['marital_statuses'],
      ),
      genders: PatientFormJsonHelpers.stringList(json['genders']),
      bloodGroups: PatientFormJsonHelpers.stringList(json['blood_groups']),
      referralTypes: PatientReferralTypeModel.listFromJson(
        json['referral_types'],
      ),
      referralFields: PatientFormJsonHelpers.stringList(
        json['referral_fields'],
      ),
      insurancePanels: PatientFormJsonHelpers.stringList(
        json['insurance_panels'],
      ),
      socialMediaPlatforms: PatientFormJsonHelpers.stringList(
        json['social_media_platforms'],
      ),
    );
  }

  /// Parse full API body or the inner data map.
  factory PatientFormDataModel.fromResponse(dynamic body) {
    final root = PatientFormJsonHelpers.mapOrNull(body);
    if (root == null) {
      return const PatientFormDataModel(
        cities: [],
        languages: [],
        maritalStatuses: [],
        genders: [],
        bloodGroups: [],
        referralTypes: [],
        referralFields: [],
        insurancePanels: [],
        socialMediaPlatforms: [],
      );
    }

    final data = PatientFormJsonHelpers.mapOrNull(root['data']) ?? root;
    return PatientFormDataModel.fromJson(data);
  }

  Map<String, dynamic> toJson() {
    return {
      'cities': cities,
      'languages': languages,
      'marital_statuses': maritalStatuses,
      'genders': genders,
      'blood_groups': bloodGroups,
      'referral_types': referralTypes
          .map(
            (type) => type is PatientReferralTypeModel
                ? type.toJson()
                : {
                    'key': type.key,
                    'label': type.label,
                    'needs_field': type.needsField,
                    'needs_panel': type.needsPanel,
                    'needs_social': type.needsSocial,
                    'needs_text': type.needsText,
                  },
          )
          .toList(),
      'referral_fields': referralFields,
      'insurance_panels': insurancePanels,
      'social_media_platforms': socialMediaPlatforms,
    };
  }

  bool get hasDropdowns =>
      cities.isNotEmpty || genders.isNotEmpty || languages.isNotEmpty;

  PatientFormDataEntity toEntity() {
    return PatientFormDataEntity(
      cities: _titleList(cities),
      languages: _titleList(languages),
      maritalStatuses: _titleList(maritalStatuses),
      genders: _titleList(genders),
      bloodGroups: _titleList(bloodGroups),
      referralTypes: referralTypes
          .map(
            (type) {
              final entity = type is PatientReferralTypeModel
                  ? type.toEntity()
                  : type;
              return PatientReferralTypeEntity(
                key: entity.key,
                label: PatientFormJsonHelpers.titleCase(entity.label),
                needsField: entity.needsField,
                needsPanel: entity.needsPanel,
                needsSocial: entity.needsSocial,
                needsText: entity.needsText,
              );
            },
          )
          .toList(),
      referralFields: _titleList(referralFields),
      insurancePanels: _titleList(insurancePanels),
      socialMediaPlatforms: _titleList(socialMediaPlatforms),
    );
  }

  static List<String> _titleList(List<String> values) {
    return values
        .map(PatientFormJsonHelpers.titleCase)
        .where((value) => value.isNotEmpty)
        .toList();
  }
}
