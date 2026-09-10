import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT CREATE FORM (Domain)
// ------------------------------------------------------------
// Values collected from the registration wizard for POST create.
// ============================================================

class PatientCreateFormEntity extends Equatable {
  const PatientCreateFormEntity({
    this.id = '',
    this.name = '',
    this.fatherHusbandName = '',
    this.email = '',
    this.phone = '',
    this.cnic = '',
    this.passportNo = '',
    this.gender = '',
    this.birthDate = '',
    this.age = '',
    this.city = '',
    this.cityOther = '',
    this.referByLabel = '',
    this.referralField = '',
    this.insurancePanel = '',
    this.socialMedia = '',
    this.otherReferral = '',
    this.emergencyContactPhone = '',
    this.bloodGroup = '',
    this.language = '',
    this.languagesOther = '',
    this.maritalStatus = '',
    this.imageName = '',
    this.imageBytes = const [],
    this.imageUrl = '',
  });

  final String id;
  final String name;
  final String fatherHusbandName;
  final String email;
  final String phone;
  final String cnic;
  final String passportNo;
  final String gender;
  final String birthDate;
  final String age;
  final String city;
  final String cityOther;
  final String referByLabel;
  final String referralField;
  final String insurancePanel;
  final String socialMedia;
  final String otherReferral;
  final String emergencyContactPhone;
  final String bloodGroup;
  final String language;
  final String languagesOther;
  final String maritalStatus;
  final String imageName;
  final List<int> imageBytes;
  final String imageUrl;

  /// Docs examples send the referral type label.
  /// Extra dropdown/text is appended so that detail is not lost.
  String get referByForApi {
    final type = referByLabel.trim();
    final extra = _referByExtra.trim();
    if (type.isEmpty) return extra;
    if (extra.isEmpty) return type;
    return '$type - $extra';
  }

  String get _referByExtra {
    if (referralField.trim().isNotEmpty) return referralField.trim();
    if (insurancePanel.trim().isNotEmpty) return insurancePanel.trim();
    if (socialMedia.trim().isNotEmpty) return socialMedia.trim();
    if (otherReferral.trim().isNotEmpty) return otherReferral.trim();
    return '';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        fatherHusbandName,
        email,
        phone,
        cnic,
        passportNo,
        gender,
        birthDate,
        age,
        city,
        cityOther,
        referByLabel,
        referralField,
        insurancePanel,
        socialMedia,
        otherReferral,
        emergencyContactPhone,
        bloodGroup,
        language,
        languagesOther,
        maritalStatus,
        imageName,
        imageBytes,
        imageUrl,
      ];
}
