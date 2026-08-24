import 'package:equatable/equatable.dart';

import 'edit_employee_document_entry.dart';
import 'edit_employee_education_entry.dart';
import 'edit_employee_experience_entry.dart';

// ============================================================
// EDIT EMPLOYEE FORM (Domain)
// ------------------------------------------------------------
// All fields the edit screen can send on Submit.
// ============================================================

class EditEmployeeFormEntity extends Equatable {
  const EditEmployeeFormEntity({
    required this.id,
    this.name = '',
    this.employeeCode = '',
    this.email = '',
    this.password = '',
    this.clinicId = '',
    this.clinicName = '',
    this.roomId = '',
    this.roomName = '',
    this.roleIds = const [],
    this.roleNames = const [],
    this.allowLogin = true,
    this.imageUrl = '',
    this.profilePicturePath = '',
    this.profilePictureName = '',
    this.profilePictureBytes = const [],
    this.departmentId = '',
    this.departmentName = '',
    this.designationId = '',
    this.designationName = '',
    this.shiftId = '',
    this.shiftName = '',
    this.biometricId = '',
    this.gender = '',
    this.phone = '',
    this.cnic = '',
    this.dateOfBirth = '',
    this.joiningDate = '',
    this.emergencyName = '',
    this.emergencyRelationship = '',
    this.emergencyPhone = '',
    this.religion = '',
    this.bloodGroup = '',
    this.district = '',
    this.experienceYears = '',
    this.salaryType = '',
    this.salary = '',
    this.presentAddress = '',
    this.permanentAddress = '',
    this.biography = '',
    this.bankName = '',
    this.branch = '',
    this.branchCode = '',
    this.accountHolder = '',
    this.accountNumber = '',
    this.iban = '',
    this.documents = const [],
    this.educations = const [],
    this.experiences = const [],
  });

  final String id;
  final String name;
  final String employeeCode;
  final String email;
  final String password;
  final String clinicId;
  final String clinicName;
  final String roomId;
  final String roomName;
  final List<String> roleIds;
  final List<String> roleNames;
  final bool allowLogin;
  final String imageUrl;
  final String profilePicturePath;
  final String profilePictureName;
  final List<int> profilePictureBytes;
  final String departmentId;
  final String departmentName;
  final String designationId;
  final String designationName;
  final String shiftId;
  final String shiftName;
  final String biometricId;
  final String gender;
  final String phone;
  final String cnic;
  final String dateOfBirth;
  final String joiningDate;
  final String emergencyName;
  final String emergencyRelationship;
  final String emergencyPhone;
  final String religion;
  final String bloodGroup;
  final String district;
  final String experienceYears;
  final String salaryType;
  final String salary;
  final String presentAddress;
  final String permanentAddress;
  final String biography;
  final String bankName;
  final String branch;
  final String branchCode;
  final String accountHolder;
  final String accountNumber;
  final String iban;
  final List<EditEmployeeDocumentEntry> documents;
  final List<EditEmployeeEducationEntry> educations;
  final List<EditEmployeeExperienceEntry> experiences;

  @override
  List<Object?> get props => [
        id,
        name,
        employeeCode,
        email,
        password,
        clinicId,
        clinicName,
        roomId,
        roomName,
        roleIds,
        roleNames,
        allowLogin,
        imageUrl,
        profilePicturePath,
        profilePictureName,
        departmentId,
        departmentName,
        designationId,
        designationName,
        shiftId,
        shiftName,
        biometricId,
        gender,
        phone,
        cnic,
        dateOfBirth,
        joiningDate,
        emergencyName,
        emergencyRelationship,
        emergencyPhone,
        religion,
        bloodGroup,
        district,
        experienceYears,
        salaryType,
        salary,
        presentAddress,
        permanentAddress,
        biography,
        bankName,
        branch,
        branchCode,
        accountHolder,
        accountNumber,
        iban,
        documents,
        educations,
        experiences,
      ];
}
