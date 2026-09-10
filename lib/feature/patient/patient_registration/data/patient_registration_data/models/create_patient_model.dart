import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/models/patient_form_json_helpers.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/create_patient_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_create_form_entity.dart';

// ============================================================
// CREATE PATIENT MODEL (Data)
// ------------------------------------------------------------
// POST /api/admin/patients/create
// JSON body, or multipart when an image file is chosen.
// ============================================================

class CreatePatientModel extends CreatePatientEntity {
  const CreatePatientModel({
    required super.message,
    super.username,
    super.password,
  });

  factory CreatePatientModel.fromJson(Map<String, dynamic> json) {
    final message = PatientFormJsonHelpers.text(json['message']);
    return CreatePatientModel(
      message: message.isEmpty
          ? 'Patient registered successfully!'
          : message,
      username: PatientFormJsonHelpers.text(json['username']),
      password: PatientFormJsonHelpers.text(json['password']),
    );
  }

  CreatePatientEntity toEntity() {
    return CreatePatientEntity(
      message: message,
      username: username,
      password: password,
    );
  }

  /// JSON or multipart (when a patient photo is chosen).
  static dynamic requestPayload({required PatientCreateFormEntity form}) {
    final body = requestBody(form: form);
    if (form.imageBytes.isEmpty) return body;

    final fileName = form.imageName.trim().isEmpty
        ? 'patient.jpg'
        : form.imageName.trim();
    body['image'] = MultipartFile.fromBytes(
      form.imageBytes,
      filename: fileName,
    );
    return FormData.fromMap(body, ListFormat.multiCompatible);
  }

  static Map<String, dynamic> requestBody({
    required PatientCreateFormEntity form,
  }) {
    final languages = <String>[];
    final language = form.language.trim();
    if (language.isNotEmpty) languages.add(language);

    final body = <String, dynamic>{
      'name': form.name.trim(),
      'email': form.email.trim(),
      'father_husband_name': form.fatherHusbandName.trim(),
      'phone': form.phone.trim(),
      'cnic': form.cnic.trim(),
      'passport_no': form.passportNo.trim(),
      'gender': form.gender.trim(),
      'birth_date': PatientFormJsonHelpers.apiDate(form.birthDate),
      'city': form.city.trim(),
      'city_other': form.cityOther.trim(),
      'refer_by': form.referByForApi,
      'emergency_contact_phone': form.emergencyContactPhone.trim(),
      'blood_group': form.bloodGroup.trim(),
      'languages': languages,
      'languages_other': form.languagesOther.trim(),
      'marital_status': form.maritalStatus.trim().toLowerCase(),
      'status': 'Registered',
    };

    final age = PatientFormJsonHelpers.ageNumber(form.age);
    if (age != null) body['age'] = age;

    const requiredKeys = {
      'name',
      'email',
      'father_husband_name',
      'phone',
      'gender',
      'birth_date',
      'city',
      'refer_by',
      'languages',
      'marital_status',
      'status',
    };

    body.removeWhere((key, value) {
      if (requiredKeys.contains(key)) return false;
      if (value == null) return true;
      if (value is String && value.isEmpty) return true;
      if (value is List && value.isEmpty) return true;
      return false;
    });

    return body;
  }
}
