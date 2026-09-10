import 'package:equatable/equatable.dart';

import 'patient_referral_type_entity.dart';

// ============================================================
// PATIENT FORM DATA ENTITY (Domain)
// ------------------------------------------------------------
// Dropdown lists from GET patients/form-data.
// ============================================================

class PatientFormDataEntity extends Equatable {
  const PatientFormDataEntity({
    required this.cities,
    required this.languages,
    required this.maritalStatuses,
    required this.genders,
    required this.bloodGroups,
    required this.referralTypes,
    required this.referralFields,
    required this.insurancePanels,
    required this.socialMediaPlatforms,
  });

  final List<String> cities;
  final List<String> languages;
  final List<String> maritalStatuses;
  final List<String> genders;
  final List<String> bloodGroups;
  final List<PatientReferralTypeEntity> referralTypes;
  final List<String> referralFields;
  final List<String> insurancePanels;
  final List<String> socialMediaPlatforms;

  const PatientFormDataEntity.empty()
      : cities = const [],
        languages = const [],
        maritalStatuses = const [],
        genders = const [],
        bloodGroups = const [],
        referralTypes = const [],
        referralFields = const [],
        insurancePanels = const [],
        socialMediaPlatforms = const [];

  /// Dropdown labels for Refer By (Type).
  List<String> get referralLabels {
    return referralTypes
        .map((type) => type.label)
        .where((label) => label.isNotEmpty)
        .toList();
  }

  PatientReferralTypeEntity? referralTypeForLabel(String? label) {
    final text = (label ?? '').trim();
    if (text.isEmpty) return null;
    for (final type in referralTypes) {
      if (type.label == text || type.key == text) return type;
    }
    return null;
  }

  @override
  List<Object?> get props => [
        cities,
        languages,
        maritalStatuses,
        genders,
        bloodGroups,
        referralTypes,
        referralFields,
        insurancePanels,
        socialMediaPlatforms,
      ];
}
