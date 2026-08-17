import 'package:equatable/equatable.dart';

import 'profile_document_entity.dart';
import 'profile_education_entity.dart';
import 'profile_experience_entity.dart';

// ============================================================
// PROFILE ENTITY (Domain)
// ------------------------------------------------------------
// Full employee profile (View) — header + all sections.
// String fields use "_" when API sends null (set in the Model).
// ============================================================

class ProfileEntity extends Equatable {
  // Header
  final String id;
  final String name;
  final String employeeId;
  final String imageUrl;
  final String role;
  final String clinic;

  // Personal
  final String gender;
  final String dateOfBirth;
  final String religion;
  final String bloodGroup;
  final String email;
  final String phone;
  final String cnic;

  // Emergency
  final String emergencyName;
  final String emergencyRelationship;
  final String emergencyPhone;

  // Employment
  final String department;
  final String designation;
  final String room;
  final String joiningDate;
  final String salaryType;
  final String salary;

  // Addresses
  final String district;
  final String presentAddress;
  final String permanentAddress;

  // Biography
  final String biography;

  // Bank
  final String bank;
  final String branch;
  final String branchCode;
  final String accountHolder;
  final String accountNumber;
  final String iban;

  // Audit
  final String createdBy;
  final String updatedBy;

  // Nested lists
  final List<ProfileDocumentEntity> documents;
  final List<ProfileEducationEntity> educations;
  final List<ProfileExperienceEntity> experiences;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.employeeId,
    required this.imageUrl,
    required this.role,
    required this.clinic,
    required this.gender,
    required this.dateOfBirth,
    required this.religion,
    required this.bloodGroup,
    required this.email,
    required this.phone,
    required this.cnic,
    required this.emergencyName,
    required this.emergencyRelationship,
    required this.emergencyPhone,
    required this.department,
    required this.designation,
    required this.room,
    required this.joiningDate,
    required this.salaryType,
    required this.salary,
    required this.district,
    required this.presentAddress,
    required this.permanentAddress,
    required this.biography,
    required this.bank,
    required this.branch,
    required this.branchCode,
    required this.accountHolder,
    required this.accountNumber,
    required this.iban,
    required this.createdBy,
    required this.updatedBy,
    this.documents = const [],
    this.educations = const [],
    this.experiences = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        employeeId,
        imageUrl,
        role,
        clinic,
        gender,
        dateOfBirth,
        religion,
        bloodGroup,
        email,
        phone,
        cnic,
        emergencyName,
        emergencyRelationship,
        emergencyPhone,
        department,
        designation,
        room,
        joiningDate,
        salaryType,
        salary,
        district,
        presentAddress,
        permanentAddress,
        biography,
        bank,
        branch,
        branchCode,
        accountHolder,
        accountNumber,
        iban,
        createdBy,
        updatedBy,
        documents,
        educations,
        experiences,
      ];
}
