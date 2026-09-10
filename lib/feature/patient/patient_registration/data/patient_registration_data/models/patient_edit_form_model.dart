import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/models/patient_form_json_helpers.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_create_form_entity.dart';

// ============================================================
// PATIENT EDIT FORM MODEL (Data)
// ------------------------------------------------------------
// Parses GET patient/{id} (or a full-view profile wrapper)
// into the same fields the registration form uses.
// ============================================================

class PatientEditFormModel extends PatientCreateFormEntity {
  const PatientEditFormModel({
    super.id,
    super.name,
    super.fatherHusbandName,
    super.email,
    super.phone,
    super.cnic,
    super.passportNo,
    super.gender,
    super.birthDate,
    super.age,
    super.city,
    super.cityOther,
    super.referByLabel,
    super.referralField,
    super.insurancePanel,
    super.socialMedia,
    super.otherReferral,
    super.emergencyContactPhone,
    super.bloodGroup,
    super.language,
    super.languagesOther,
    super.maritalStatus,
    super.imageUrl,
  });

  factory PatientEditFormModel.fromJson(Map<String, dynamic> json) {
    final birth = PatientFormJsonHelpers.fieldOf(json, const [
      'birth_date',
      'date_of_birth',
      'dob',
    ]);
    final image = PatientFormJsonHelpers.fieldOf(json, const [
      'image',
      'photo',
      'profile_picture',
      'picture',
      'avatar',
    ]);

    return PatientEditFormModel(
      id: PatientFormJsonHelpers.fieldOf(json, const ['id', 'patient_id']),
      name: PatientFormJsonHelpers.fieldOf(json, const [
        'name',
        'full_name',
        'patient_name',
      ]),
      fatherHusbandName: PatientFormJsonHelpers.fieldOf(json, const [
        'father_husband_name',
        'father_name',
        'husband_name',
        'guardian_name',
      ]),
      email: PatientFormJsonHelpers.fieldOf(json, const ['email']),
      phone: PatientFormJsonHelpers.fieldOf(json, const [
        'phone',
        'mobile',
        'contact',
      ]),
      cnic: PatientFormJsonHelpers.fieldOf(json, const ['cnic']),
      passportNo: PatientFormJsonHelpers.fieldOf(json, const [
        'passport_no',
        'passport',
      ]),
      gender: PatientFormJsonHelpers.fieldOf(json, const ['gender']),
      birthDate: PatientFormJsonHelpers.displayDate(birth),
      age: PatientFormJsonHelpers.ageText(json['age']),
      city: PatientFormJsonHelpers.fieldOf(json, const ['city']),
      cityOther: PatientFormJsonHelpers.fieldOf(json, const [
        'city_other',
        'other_city',
      ]),
      referByLabel: PatientFormJsonHelpers.fieldOf(json, const [
        'refer_by',
        'referred_by',
        'referral',
      ]),
      referralField: PatientFormJsonHelpers.fieldOf(json, const [
        'referral_field',
        'field',
      ]),
      insurancePanel: PatientFormJsonHelpers.fieldOf(json, const [
        'insurance_panel',
        'insurance',
        'panel',
      ]),
      socialMedia: PatientFormJsonHelpers.fieldOf(json, const [
        'social_media',
        'social_media_platform',
      ]),
      otherReferral: PatientFormJsonHelpers.fieldOf(json, const [
        'other_referral',
        'refer_by_other',
      ]),
      emergencyContactPhone: PatientFormJsonHelpers.fieldOf(json, const [
        'emergency_contact_phone',
        'emergency_phone',
      ]),
      bloodGroup: PatientFormJsonHelpers.fieldOf(json, const [
        'blood_group',
      ]),
      language: PatientFormJsonHelpers.firstLanguage(
        json['languages'] ?? json['language'],
      ),
      languagesOther: PatientFormJsonHelpers.fieldOf(json, const [
        'languages_other',
        'language_other',
        'other_language',
      ]),
      maritalStatus: PatientFormJsonHelpers.fieldOf(json, const [
        'marital_status',
      ]),
      imageUrl: image.isEmpty ? '' : ApiConstants.resolveFileUrl(image),
    );
  }

  /// Accept the full envelope, data.patient, data.profile, or data.user.
  factory PatientEditFormModel.fromResponse(dynamic body) {
    return PatientEditFormModel.fromJson(_unwrapPatient(body));
  }

  /// Prefer a nested map that actually has a name, then merge leftovers.
  static Map<String, dynamic> _unwrapPatient(dynamic body) {
    final root = PatientFormJsonHelpers.mapOrNull(body) ?? <String, dynamic>{};
    final data = PatientFormJsonHelpers.mapOrNull(root['data']) ?? root;
    final nested = <Map<String, dynamic>>[
      ?PatientFormJsonHelpers.mapOrNull(data['patient']),
      ?PatientFormJsonHelpers.mapOrNull(data['profile']),
      ?PatientFormJsonHelpers.mapOrNull(data['user']),
      ?PatientFormJsonHelpers.mapOrNull(root['patient']),
      ?PatientFormJsonHelpers.mapOrNull(root['profile']),
    ];

    for (final map in nested) {
      final name = PatientFormJsonHelpers.fieldOf(map, const [
        'name',
        'full_name',
        'patient_name',
      ]);
      if (name.isNotEmpty) {
        return {...data, ...map};
      }
    }

    return {...data, for (final map in nested) ...map};
  }

  /// Show/full-view merge: keep any non-empty value (other wins).
  PatientEditFormModel mergedWith(PatientEditFormModel other) {
    String pick(String primary, String fallback) {
      return primary.trim().isNotEmpty ? primary : fallback;
    }

    return PatientEditFormModel(
      id: pick(other.id, id),
      name: pick(other.name, name),
      fatherHusbandName: pick(other.fatherHusbandName, fatherHusbandName),
      email: pick(other.email, email),
      phone: pick(other.phone, phone),
      cnic: pick(other.cnic, cnic),
      passportNo: pick(other.passportNo, passportNo),
      gender: pick(other.gender, gender),
      birthDate: pick(other.birthDate, birthDate),
      age: pick(other.age, age),
      city: pick(other.city, city),
      cityOther: pick(other.cityOther, cityOther),
      referByLabel: pick(other.referByLabel, referByLabel),
      referralField: pick(other.referralField, referralField),
      insurancePanel: pick(other.insurancePanel, insurancePanel),
      socialMedia: pick(other.socialMedia, socialMedia),
      otherReferral: pick(other.otherReferral, otherReferral),
      emergencyContactPhone: pick(
        other.emergencyContactPhone,
        emergencyContactPhone,
      ),
      bloodGroup: pick(other.bloodGroup, bloodGroup),
      language: pick(other.language, language),
      languagesOther: pick(other.languagesOther, languagesOther),
      maritalStatus: pick(other.maritalStatus, maritalStatus),
      imageUrl: pick(other.imageUrl, imageUrl),
    );
  }

  PatientCreateFormEntity toEntity() {
    return PatientCreateFormEntity(
      id: id,
      name: name,
      fatherHusbandName: fatherHusbandName,
      email: email,
      phone: phone,
      cnic: cnic,
      passportNo: passportNo,
      gender: gender,
      birthDate: birthDate,
      age: age,
      city: city,
      cityOther: cityOther,
      referByLabel: referByLabel,
      referralField: referralField,
      insurancePanel: insurancePanel,
      socialMedia: socialMedia,
      otherReferral: otherReferral,
      emergencyContactPhone: emergencyContactPhone,
      bloodGroup: bloodGroup,
      language: language,
      languagesOther: languagesOther,
      maritalStatus: maritalStatus,
      imageUrl: imageUrl,
    );
  }
}
