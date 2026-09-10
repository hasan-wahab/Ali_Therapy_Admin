import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/utils/app_input_formatters.dart';
import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_create_form_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_form_data_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_referral_type_entity.dart';

// ============================================================
// PATIENT REGISTRATION FORM CONTROLLERS
// ------------------------------------------------------------
// Holds field values across steps so Register can read everything.
// ============================================================

class PatientRegistrationFormControllers extends ChangeNotifier {
  PatientRegistrationFormControllers()
      : name = TextEditingController(),
        fatherHusbandName = TextEditingController(),
        email = TextEditingController(),
        phone = TextEditingController(),
        cnic = TextEditingController(),
        passportNo = TextEditingController(),
        age = TextEditingController(),
        cityOther = TextEditingController(),
        emergencyContactPhone = TextEditingController(),
        languagesOther = TextEditingController(),
        otherReferral = TextEditingController() {
    _bindClearError(name, nameKey);
    _bindClearError(fatherHusbandName, fatherNameKey);
    _bindClearError(email, emailKey);
    _bindClearError(phone, phoneKey);
    _bindClearError(cnic, cnicKey);
    _bindClearError(passportNo, passportKey);
    _bindClearError(emergencyContactPhone, emergencyPhoneKey);
    _bindClearError(cityOther, cityOtherKey);
    _bindClearError(languagesOther, languagesOtherKey);
    _bindClearError(otherReferral, otherReferralKey);
  }

  static const nameKey = 'name';
  static const fatherNameKey = 'fatherName';
  static const emailKey = 'email';
  static const phoneKey = 'phone';
  static const cnicKey = 'cnic';
  static const passportKey = 'passport';
  static const emergencyPhoneKey = 'emergencyPhone';
  static const genderKey = 'gender';
  static const birthDateKey = 'birthDate';
  static const cityKey = 'city';
  static const cityOtherKey = 'cityOther';
  static const referByKey = 'referBy';
  static const referralFieldKey = 'referralField';
  static const insurancePanelKey = 'insurancePanel';
  static const socialMediaKey = 'socialMedia';
  static const otherReferralKey = 'otherReferral';
  static const languageKey = 'language';
  static const languagesOtherKey = 'languagesOther';
  static const maritalKey = 'marital';

  Set<String> invalidFields = {};

  final TextEditingController name;
  final TextEditingController fatherHusbandName;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController cnic;
  final TextEditingController passportNo;
  final TextEditingController age;
  final TextEditingController cityOther;
  final TextEditingController emergencyContactPhone;
  final TextEditingController languagesOther;
  final TextEditingController otherReferral;

  String gender = '';
  String birthDate = '';
  String city = '';
  String referByLabel = '';
  String referralField = '';
  String insurancePanel = '';
  String socialMedia = '';
  String bloodGroup = '';
  String language = '';
  String maritalStatus = '';
  String imageName = '';
  List<int> imageBytes = const [];
  String imageUrl = '';
  String patientId = '';

  static bool isOtherValue(String? value) {
    return (value ?? '').trim().toLowerCase() == 'other';
  }

  bool isInvalid(String key) => invalidFields.contains(key);

  void setGender(String? value) {
    gender = value?.trim() ?? '';
    _clearKey(genderKey);
    notifyListeners();
  }

  void setBirthDate(String value) {
    birthDate = value.trim();
    _clearKey(birthDateKey);
    notifyListeners();
  }

  void setCity(String? value) {
    city = value?.trim() ?? '';
    if (!isOtherValue(city)) cityOther.clear();
    _clearKey(cityKey);
    _clearKey(cityOtherKey);
    notifyListeners();
  }

  void setReferByLabel(String? value) {
    referByLabel = value?.trim() ?? '';
    referralField = '';
    insurancePanel = '';
    socialMedia = '';
    otherReferral.clear();
    _clearKey(referByKey);
    _clearKey(referralFieldKey);
    _clearKey(insurancePanelKey);
    _clearKey(socialMediaKey);
    _clearKey(otherReferralKey);
    notifyListeners();
  }

  void setReferralField(String? value) {
    referralField = value?.trim() ?? '';
    _clearKey(referralFieldKey);
    notifyListeners();
  }

  void setInsurancePanel(String? value) {
    insurancePanel = value?.trim() ?? '';
    _clearKey(insurancePanelKey);
    notifyListeners();
  }

  void setSocialMedia(String? value) {
    socialMedia = value?.trim() ?? '';
    _clearKey(socialMediaKey);
    notifyListeners();
  }

  void setBloodGroup(String? value) {
    bloodGroup = value?.trim() ?? '';
    notifyListeners();
  }

  void setLanguage(String? value) {
    language = value?.trim() ?? '';
    if (!isOtherValue(language)) languagesOther.clear();
    _clearKey(languageKey);
    _clearKey(languagesOtherKey);
    notifyListeners();
  }

  void setMaritalStatus(String? value) {
    maritalStatus = value?.trim() ?? '';
    _clearKey(maritalKey);
    notifyListeners();
  }

  void setImage({required List<int> bytes, required String name}) {
    imageBytes = bytes;
    imageName = name;
    notifyListeners();
  }

  /// Prefill Edit from GET patient/{id} + form-data lists.
  void fillFrom(
    PatientCreateFormEntity patient,
    PatientFormDataEntity formData,
  ) {
    patientId = patient.id;
    imageUrl = patient.imageUrl;
    imageBytes = const [];
    imageName = '';
    invalidFields = {};

    name.text = Helpers.titleCase(patient.name);
    fatherHusbandName.text = Helpers.titleCase(patient.fatherHusbandName);
    email.text = patient.email;
    phone.text = AppInputFormatters.formatPhone(patient.phone);
    cnic.text = AppInputFormatters.formatCnic(patient.cnic);
    passportNo.text = AppInputFormatters.formatPassport(patient.passportNo);
    age.text = AppInputFormatters.digitsOnly(patient.age, max: 3);
    emergencyContactPhone.text = AppInputFormatters.formatPhone(
      patient.emergencyContactPhone,
    );
    birthDate = patient.birthDate;
    gender = _matchOption(patient.gender, formData.genders);
    bloodGroup = _matchOption(
      patient.bloodGroup,
      formData.bloodGroups,
    );

    _fillCity(patient, formData);
    _fillLanguage(patient, formData);
    _fillReferral(patient, formData);

    maritalStatus = _matchOption(
      patient.maritalStatus,
      formData.maritalStatuses,
    );

    notifyListeners();
  }

  String? validateStep(int step, PatientFormDataEntity formData) {
    switch (step) {
      case 0:
        return _validateBasic();
      case 1:
        return _validateDetails(formData);
      default:
        _setInvalid({});
        return null;
    }
  }

  String? validateForCreate(PatientFormDataEntity formData) {
    return validateStep(0, formData) ?? validateStep(1, formData);
  }

  PatientCreateFormEntity toForm() {
    return PatientCreateFormEntity(
      id: patientId,
      name: Helpers.titleCase(name.text),
      fatherHusbandName: Helpers.titleCase(fatherHusbandName.text),
      email: email.text.trim(),
      phone: phone.text,
      cnic: cnic.text,
      passportNo: passportNo.text,
      gender: gender,
      birthDate: birthDate,
      age: age.text,
      city: city,
      cityOther: Helpers.titleCase(cityOther.text),
      referByLabel: referByLabel,
      referralField: referralField,
      insurancePanel: insurancePanel,
      socialMedia: socialMedia,
      otherReferral: Helpers.sentenceCase(otherReferral.text),
      emergencyContactPhone: emergencyContactPhone.text,
      bloodGroup: bloodGroup,
      language: language,
      languagesOther: Helpers.titleCase(languagesOther.text),
      maritalStatus: maritalStatus,
      imageName: imageName,
      imageBytes: imageBytes,
      imageUrl: imageUrl,
    );
  }

  void disposeAll() {
    name.dispose();
    fatherHusbandName.dispose();
    email.dispose();
    phone.dispose();
    cnic.dispose();
    passportNo.dispose();
    age.dispose();
    cityOther.dispose();
    emergencyContactPhone.dispose();
    languagesOther.dispose();
    otherReferral.dispose();
    super.dispose();
  }

  String? _validateBasic() {
    final errors = <String, String>{};
    if (name.text.trim().isEmpty) {
      errors[nameKey] = 'Name is required.';
    }
    if (fatherHusbandName.text.trim().isEmpty) {
      errors[fatherNameKey] = 'Father name is required.';
    }
    final emailValue = email.text.trim();
    if (emailValue.isEmpty) {
      errors[emailKey] = 'Email is required.';
    } else if (!emailValue.contains('@')) {
      errors[emailKey] = 'Enter a valid email.';
    }
    if (phone.text.trim().isEmpty) {
      errors[phoneKey] = 'Phone is required.';
    } else if (!AppInputFormatters.isCompletePhone(phone.text)) {
      errors[phoneKey] = 'Phone must be 11 digits.';
    }
    final cnicValue = cnic.text.trim();
    if (cnicValue.isNotEmpty && !AppInputFormatters.isCompleteCnic(cnicValue)) {
      errors[cnicKey] = 'CNIC must be 12345-1234567-1.';
    }
    final passportValue = passportNo.text.trim();
    if (passportValue.isNotEmpty &&
        !AppInputFormatters.isCompletePassport(passportValue)) {
      errors[passportKey] = 'Passport must be 9 characters.';
    }
    if (gender.trim().isEmpty) {
      errors[genderKey] = 'Gender is required.';
    }
    if (birthDate.trim().isEmpty) {
      errors[birthDateKey] = 'Birth date is required.';
    }
    if (city.trim().isEmpty) {
      errors[cityKey] = 'City is required.';
    } else if (isOtherValue(city) && cityOther.text.trim().isEmpty) {
      errors[cityOtherKey] = 'Other city is required.';
    }
    _setInvalid(errors);
    return errors.isEmpty ? null : errors.values.first;
  }

  String? _validateDetails(PatientFormDataEntity formData) {
    final errors = <String, String>{};
    if (referByLabel.trim().isEmpty) {
      errors[referByKey] = 'Referral type is required.';
    } else {
      final type = formData.referralTypeForLabel(referByLabel);
      if (type != null &&
          type.needsField &&
          formData.referralFields.isNotEmpty &&
          referralField.trim().isEmpty) {
        errors[referralFieldKey] = 'Referral field is required.';
      }
      if (type != null &&
          type.needsPanel &&
          formData.insurancePanels.isNotEmpty &&
          insurancePanel.trim().isEmpty) {
        errors[insurancePanelKey] = 'Insurance panel is required.';
      }
      if (type != null &&
          type.needsSocial &&
          formData.socialMediaPlatforms.isNotEmpty &&
          socialMedia.trim().isEmpty) {
        errors[socialMediaKey] = 'Social media is required.';
      }
      if (type != null &&
          type.needsText &&
          otherReferral.text.trim().isEmpty) {
        errors[otherReferralKey] = 'Other referral is required.';
      }
    }
    if (language.trim().isEmpty) {
      errors[languageKey] = 'Language is required.';
    } else if (isOtherValue(language) && languagesOther.text.trim().isEmpty) {
      errors[languagesOtherKey] = 'Other language is required.';
    }
    if (maritalStatus.trim().isEmpty) {
      errors[maritalKey] = 'Marital status is required.';
    }
    final emergencyPhone = emergencyContactPhone.text.trim();
    if (emergencyPhone.isNotEmpty &&
        !AppInputFormatters.isCompletePhone(emergencyPhone)) {
      errors[emergencyPhoneKey] = 'Emergency phone must be 11 digits.';
    }
    _setInvalid(errors);
    return errors.isEmpty ? null : errors.values.first;
  }

  void _bindClearError(TextEditingController controller, String key) {
    controller.addListener(() {
      if (!invalidFields.contains(key)) return;
      if (controller.text.trim().isEmpty) return;
      _clearKey(key);
      notifyListeners();
    });
  }

  void _clearKey(String key) {
    if (!invalidFields.contains(key)) return;
    invalidFields = {...invalidFields}..remove(key);
  }

  void _setInvalid(Map<String, String> errors) {
    invalidFields = errors.keys.toSet();
    notifyListeners();
  }

  void _fillCity(
    PatientCreateFormEntity patient,
    PatientFormDataEntity formData,
  ) {
    final matched = _matchOption(
      patient.city,
      formData.cities,
    );
    if (matched.isNotEmpty) {
      city = matched;
      cityOther.text = isOtherValue(matched)
          ? Helpers.titleCase(patient.cityOther)
          : '';
      return;
    }

    final other = _matchOption('Other', formData.cities);
    if (other.isNotEmpty &&
        (patient.cityOther.trim().isNotEmpty || patient.city.trim().isNotEmpty)) {
      city = other;
      cityOther.text = Helpers.titleCase(
        patient.cityOther.trim().isNotEmpty
            ? patient.cityOther
            : patient.city,
      );
      return;
    }

    city = '';
    cityOther.text = Helpers.titleCase(patient.cityOther);
  }

  void _fillLanguage(
    PatientCreateFormEntity patient,
    PatientFormDataEntity formData,
  ) {
    final matched = _matchOption(
      patient.language,
      formData.languages,
    );
    if (matched.isNotEmpty) {
      language = matched;
      languagesOther.text = isOtherValue(matched)
          ? Helpers.titleCase(patient.languagesOther)
          : '';
      return;
    }

    final other = _matchOption('Other', formData.languages);
    if (other.isNotEmpty &&
        (patient.languagesOther.trim().isNotEmpty ||
            patient.language.trim().isNotEmpty)) {
      language = other;
      languagesOther.text = Helpers.titleCase(
        patient.languagesOther.trim().isNotEmpty
            ? patient.languagesOther
            : patient.language,
      );
      return;
    }

    language = '';
    languagesOther.text = Helpers.titleCase(patient.languagesOther);
  }

  void _fillReferral(
    PatientCreateFormEntity patient,
    PatientFormDataEntity formData,
  ) {
    referralField = '';
    insurancePanel = '';
    socialMedia = '';
    otherReferral.clear();

    final raw = patient.referByLabel.trim();
    final type = _matchReferralType(raw, formData);
    if (type == null) {
      referByLabel = _matchOption(
        raw,
        formData.referralLabels,
      );
      if (referByLabel.isEmpty) {
        otherReferral.text = Helpers.sentenceCase(raw);
      }
      return;
    }

    referByLabel = type.label;
    final extra = _referralExtra(raw, type);
    if (type.needsField) {
      referralField = _matchOption(
        extra.isNotEmpty ? extra : patient.referralField,
        formData.referralFields,
      );
    } else if (type.needsPanel) {
      insurancePanel = _matchOption(
        extra.isNotEmpty ? extra : patient.insurancePanel,
        formData.insurancePanels,
      );
    } else if (type.needsSocial) {
      socialMedia = _matchOption(
        extra.isNotEmpty ? extra : patient.socialMedia,
        formData.socialMediaPlatforms,
      );
    } else if (type.needsText) {
      otherReferral.text = Helpers.sentenceCase(
        extra.isNotEmpty ? extra : patient.otherReferral,
      );
    }
  }

  PatientReferralTypeEntity? _matchReferralType(
    String raw,
    PatientFormDataEntity formData,
  ) {
    if (raw.isEmpty) return null;
    final direct = formData.referralTypeForLabel(raw);
    if (direct != null) return direct;

    final lower = raw.toLowerCase();
    for (final type in formData.referralTypes) {
      if (type.label.toLowerCase() == lower ||
          type.key.toLowerCase() == lower) {
        return type;
      }
    }

    final folded = _compact(raw);
    for (final type in formData.referralTypes) {
      if (_compact(type.label) == folded || _compact(type.key) == folded) {
        return type;
      }
    }

    for (final type in formData.referralTypes) {
      for (final prefix in [type.label, type.key]) {
        if (prefix.isEmpty) continue;
        final start = prefix.toLowerCase();
        if (lower.startsWith('$start -') || lower.startsWith('$start:')) {
          return type;
        }
      }
    }
    return null;
  }

  String _referralExtra(String raw, PatientReferralTypeEntity type) {
    for (final prefix in [type.label, type.key]) {
      if (prefix.isEmpty) continue;
      for (final sep in [' - ', ': ', ':']) {
        final needle = '$prefix$sep';
        if (raw.toLowerCase().startsWith(needle.toLowerCase())) {
          return raw.substring(needle.length).trim();
        }
      }
    }
    return '';
  }

  String _matchOption(String raw, List<String> options) {
    final value = raw.trim();
    if (value.isEmpty || options.isEmpty) return '';
    for (final option in options) {
      if (option == value) return option;
    }
    final lower = value.toLowerCase();
    for (final option in options) {
      if (option.toLowerCase() == lower) return option;
    }
    final folded = _compact(value);
    for (final option in options) {
      if (_compact(option) == folded) return option;
    }
    return '';
  }

  String _compact(String value) {
    return value.trim().toLowerCase().replaceAll(RegExp(r'[\s_\-]+'), '');
  }
}
