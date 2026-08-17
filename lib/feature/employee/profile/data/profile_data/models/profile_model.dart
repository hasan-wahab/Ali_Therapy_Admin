import '../../../domain/profile_domain/entities/profile_document_entity.dart';
import '../../../domain/profile_domain/entities/profile_education_entity.dart';
import '../../../domain/profile_domain/entities/profile_entity.dart';
import '../../../domain/profile_domain/entities/profile_experience_entity.dart';
import 'profile_document_model.dart';
import 'profile_education_model.dart';
import 'profile_experience_model.dart';
import 'profile_json_helpers.dart';

// ============================================================
// PROFILE MODEL (Data)
// ------------------------------------------------------------
// Parses employee profile (View) API JSON.
// Null / empty → "_" (see ProfileJsonHelpers.text).
// ============================================================

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.employeeId,
    required super.imageUrl,
    required super.role,
    required super.clinic,
    required super.gender,
    required super.dateOfBirth,
    required super.religion,
    required super.bloodGroup,
    required super.email,
    required super.phone,
    required super.cnic,
    required super.emergencyName,
    required super.emergencyRelationship,
    required super.emergencyPhone,
    required super.department,
    required super.designation,
    required super.room,
    required super.joiningDate,
    required super.salaryType,
    required super.salary,
    required super.district,
    required super.presentAddress,
    required super.permanentAddress,
    required super.biography,
    required super.bank,
    required super.branch,
    required super.branchCode,
    required super.accountHolder,
    required super.accountNumber,
    required super.iban,
    required super.createdBy,
    required super.updatedBy,
    super.documents,
    super.educations,
    super.experiences,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: ProfileJsonHelpers.text(json['id']),
      name: ProfileJsonHelpers.text(json['name']),
      employeeId: ProfileJsonHelpers.textOf(json, [
        'employeeId',
        'employee_id',
      ]),
      imageUrl: ProfileJsonHelpers.textOf(json, ['imageUrl', 'image_url']),
      role: ProfileJsonHelpers.text(json['role']),
      clinic: ProfileJsonHelpers.text(json['clinic']),
      gender: ProfileJsonHelpers.text(json['gender']),
      dateOfBirth: ProfileJsonHelpers.textOf(json, [
        'dateOfBirth',
        'date_of_birth',
      ]),
      religion: ProfileJsonHelpers.text(json['religion']),
      bloodGroup: ProfileJsonHelpers.textOf(json, [
        'bloodGroup',
        'blood_group',
      ]),
      email: ProfileJsonHelpers.text(json['email']),
      phone: ProfileJsonHelpers.text(json['phone']),
      cnic: ProfileJsonHelpers.text(json['cnic']),
      emergencyName: ProfileJsonHelpers.textOf(json, [
        'emergencyName',
        'emergency_name',
      ]),
      emergencyRelationship: ProfileJsonHelpers.textOf(json, [
        'emergencyRelationship',
        'emergency_relationship',
      ]),
      emergencyPhone: ProfileJsonHelpers.textOf(json, [
        'emergencyPhone',
        'emergency_phone',
      ]),
      department: ProfileJsonHelpers.text(json['department']),
      designation: ProfileJsonHelpers.text(json['designation']),
      room: ProfileJsonHelpers.text(json['room']),
      joiningDate: ProfileJsonHelpers.textOf(json, [
        'joiningDate',
        'joining_date',
      ]),
      salaryType: ProfileJsonHelpers.textOf(json, [
        'salaryType',
        'salary_type',
      ]),
      salary: ProfileJsonHelpers.text(json['salary']),
      district: ProfileJsonHelpers.text(json['district']),
      presentAddress: ProfileJsonHelpers.textOf(json, [
        'presentAddress',
        'present_address',
      ]),
      permanentAddress: ProfileJsonHelpers.textOf(json, [
        'permanentAddress',
        'permanent_address',
      ]),
      biography: ProfileJsonHelpers.text(json['biography']),
      bank: ProfileJsonHelpers.text(json['bank']),
      branch: ProfileJsonHelpers.text(json['branch']),
      branchCode: ProfileJsonHelpers.textOf(json, [
        'branchCode',
        'branch_code',
      ]),
      accountHolder: ProfileJsonHelpers.textOf(json, [
        'accountHolder',
        'account_holder',
      ]),
      accountNumber: ProfileJsonHelpers.textOf(json, [
        'accountNumber',
        'account_number',
      ]),
      iban: ProfileJsonHelpers.text(json['iban']),
      createdBy: ProfileJsonHelpers.textOf(json, [
        'createdBy',
        'created_by',
      ]),
      updatedBy: ProfileJsonHelpers.textOf(json, [
        'updatedBy',
        'updated_by',
      ]),
      documents: _documentsFromJson(json['documents']),
      educations: _educationsFromJson(json['educations']),
      experiences: _experiencesFromJson(json['experiences']),
    );
  }

  static List<ProfileDocumentEntity> _documentsFromJson(dynamic raw) {
    final list = ProfileJsonHelpers.listOrEmpty(raw);
    final result = <ProfileDocumentEntity>[];
    for (final item in list) {
      final map = ProfileJsonHelpers.mapOrNull(item);
      if (map == null) continue;
      result.add(ProfileDocumentModel.fromJson(map));
    }
    return result;
  }

  static List<ProfileEducationEntity> _educationsFromJson(dynamic raw) {
    final list = ProfileJsonHelpers.listOrEmpty(raw);
    final result = <ProfileEducationEntity>[];
    for (final item in list) {
      final map = ProfileJsonHelpers.mapOrNull(item);
      if (map == null) continue;
      result.add(ProfileEducationModel.fromJson(map));
    }
    return result;
  }

  static List<ProfileExperienceEntity> _experiencesFromJson(dynamic raw) {
    final list = ProfileJsonHelpers.listOrEmpty(raw);
    final result = <ProfileExperienceEntity>[];
    for (final item in list) {
      final map = ProfileJsonHelpers.mapOrNull(item);
      if (map == null) continue;
      result.add(ProfileExperienceModel.fromJson(map));
    }
    return result;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'employeeId': employeeId,
      'imageUrl': imageUrl,
      'role': role,
      'clinic': clinic,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'religion': religion,
      'bloodGroup': bloodGroup,
      'email': email,
      'phone': phone,
      'cnic': cnic,
      'emergencyName': emergencyName,
      'emergencyRelationship': emergencyRelationship,
      'emergencyPhone': emergencyPhone,
      'department': department,
      'designation': designation,
      'room': room,
      'joiningDate': joiningDate,
      'salaryType': salaryType,
      'salary': salary,
      'district': district,
      'presentAddress': presentAddress,
      'permanentAddress': permanentAddress,
      'biography': biography,
      'bank': bank,
      'branch': branch,
      'branchCode': branchCode,
      'accountHolder': accountHolder,
      'accountNumber': accountNumber,
      'iban': iban,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'documents': documents
          .map(
            (d) => d is ProfileDocumentModel
                ? d.toJson()
                : ProfileDocumentModel(
                    id: d.id,
                    docTitle: d.docTitle,
                    docDescription: d.docDescription,
                    docFile: d.docFile,
                    docExpiry: d.docExpiry,
                  ).toJson(),
          )
          .toList(),
      'educations': educations
          .map(
            (e) => e is ProfileEducationModel
                ? e.toJson()
                : ProfileEducationModel(
                    id: e.id,
                    degree: e.degree,
                    university: e.university,
                    cgpa: e.cgpa,
                    comments: e.comments,
                  ).toJson(),
          )
          .toList(),
      'experiences': experiences
          .map(
            (e) => e is ProfileExperienceModel
                ? e.toJson()
                : ProfileExperienceModel(
                    id: e.id,
                    companyName: e.companyName,
                    workingPeriod: e.workingPeriod,
                    duties: e.duties,
                    supervisor: e.supervisor,
                  ).toJson(),
          )
          .toList(),
    };
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      name: name,
      employeeId: employeeId,
      imageUrl: imageUrl,
      role: role,
      clinic: clinic,
      gender: gender,
      dateOfBirth: dateOfBirth,
      religion: religion,
      bloodGroup: bloodGroup,
      email: email,
      phone: phone,
      cnic: cnic,
      emergencyName: emergencyName,
      emergencyRelationship: emergencyRelationship,
      emergencyPhone: emergencyPhone,
      department: department,
      designation: designation,
      room: room,
      joiningDate: joiningDate,
      salaryType: salaryType,
      salary: salary,
      district: district,
      presentAddress: presentAddress,
      permanentAddress: permanentAddress,
      biography: biography,
      bank: bank,
      branch: branch,
      branchCode: branchCode,
      accountHolder: accountHolder,
      accountNumber: accountNumber,
      iban: iban,
      createdBy: createdBy,
      updatedBy: updatedBy,
      documents: documents
          .map(
            (d) => d is ProfileDocumentModel ? d.toEntity() : d,
          )
          .toList(),
      educations: educations
          .map(
            (e) => e is ProfileEducationModel ? e.toEntity() : e,
          )
          .toList(),
      experiences: experiences
          .map(
            (e) => e is ProfileExperienceModel ? e.toEntity() : e,
          )
          .toList(),
    );
  }
}
