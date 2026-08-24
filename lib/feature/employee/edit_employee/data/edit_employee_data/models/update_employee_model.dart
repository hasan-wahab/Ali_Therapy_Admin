import 'package:dio/dio.dart';

import '../../../domain/edit_employee_domain/entities/edit_employee_form_entity.dart';
import '../../../domain/edit_employee_domain/entities/edit_employee_option_entity.dart';
import '../../../domain/edit_employee_domain/entities/edit_employee_options_entity.dart';
import '../../../domain/edit_employee_domain/entities/update_employee_entity.dart';
import 'edit_employee_json_helpers.dart';

// ============================================================
// UPDATE EMPLOYEE MODEL (Data)
// ------------------------------------------------------------
// POST /api/admin/employees/update/{id}
// Field names match AliTherapy_Update_Employee_API.pdf
// ============================================================

class UpdateEmployeeModel extends UpdateEmployeeEntity {
  const UpdateEmployeeModel({required super.message});

  factory UpdateEmployeeModel.fromJson(Map<String, dynamic> json) {
    final raw = json['message']?.toString().trim() ?? '';
    return UpdateEmployeeModel(
      message: raw.isEmpty ? 'Employee Updated Successfully' : raw,
    );
  }

  UpdateEmployeeEntity toEntity() => UpdateEmployeeEntity(message: message);

  /// JSON or multipart (when a new profile picture is chosen).
  static dynamic requestPayload({
    required EditEmployeeFormEntity form,
    required EditEmployeeOptionsEntity options,
  }) {
    final body = requestBody(form: form, options: options);
    if (form.profilePictureBytes.isEmpty) return body;

    final fileName = form.profilePictureName.trim().isEmpty
        ? 'profile.jpg'
        : form.profilePictureName.trim();
    body['profile_picture'] = MultipartFile.fromBytes(
      form.profilePictureBytes,
      filename: fileName,
    );
    return FormData.fromMap(body, ListFormat.multiCompatible);
  }

  /// JSON body from the edit form (docs field names).
  static Map<String, dynamic> requestBody({
    required EditEmployeeFormEntity form,
    required EditEmployeeOptionsEntity options,
  }) {
    final clinicId = _resolvedId(form.clinicId, form.clinicName, options.clinics);
    final roomId = _resolvedId(form.roomId, form.roomName, options.rooms);
    final departmentId = _resolvedId(
      form.departmentId,
      form.departmentName,
      options.departments,
    );
    final designationId = _resolvedId(
      form.designationId,
      form.designationName,
      options.designations,
    );
    final shiftId = _resolvedId(form.shiftId, form.shiftName, options.shifts);

    final body = <String, dynamic>{
      'name': form.name.trim(),
      'username': form.employeeCode.trim(),
      'email': form.email.trim(),
      'phone': form.phone.trim(),
      'cnic': form.cnic.trim(),
      'gender': EditEmployeeJsonHelpers.genderApi(form.gender) ?? '',
      'blood_group': form.bloodGroup.trim(),
      'dob': EditEmployeeJsonHelpers.apiDate(form.dateOfBirth),
      'religion': form.religion.trim(),
      'district': form.district.trim(),
      'emergency_contact': form.emergencyPhone.trim(),
      'emergency_contact_name': form.emergencyName.trim(),
      'emergency_contact_relationship': form.emergencyRelationship.trim(),
      'joining_date': EditEmployeeJsonHelpers.apiDate(form.joiningDate),
      'salary_type':
          EditEmployeeJsonHelpers.salaryTypeApi(form.salaryType) ?? '',
      'experience': form.experienceYears.trim(),
      'present_address': form.presentAddress.trim(),
      'permanent_address': form.permanentAddress.trim(),
      'biography': form.biography.trim(),
      'banck_name': form.bankName.trim(),
      'banck_branch': form.branch.trim(),
      'banck_branch_code': form.branchCode.trim(),
      'banck_account_holder': form.accountHolder.trim(),
      'banck_account_number': form.accountNumber.trim(),
      'banck_iban_number': form.iban.trim(),
    };

    _putId(body, 'department_id', departmentId);
    _putId(body, 'designation_id', designationId);
    _putId(body, 'shift_id', shiftId);
    _putId(body, 'clinic_id', clinicId);
    _putId(body, 'room_id', roomId);

    final salary = EditEmployeeJsonHelpers.salaryNumber(form.salary);
    if (salary != null) body['salary'] = salary;

    final password = form.password.trim();
    if (password.isNotEmpty) {
      body['password'] = password;
    }

    final education = form.educations.where((row) => !row.isEmpty).toList();
    if (education.isNotEmpty) {
      body['education'] = [
        for (final row in education)
          {
            if (row.id.trim().isNotEmpty)
              'id': EditEmployeeJsonHelpers.idValue(row.id),
            'degree': row.degree.trim(),
            'university': row.university.trim(),
            'cgpa': row.cgpa.trim(),
            'comments': row.comments.trim(),
          },
      ];
    }

    final experienceRows =
        form.experiences.where((row) => !row.isEmpty).toList();
    if (experienceRows.isNotEmpty) {
      body['experience_rows'] = [
        for (final row in experienceRows)
          {
            if (row.id.trim().isNotEmpty)
              'id': EditEmployeeJsonHelpers.idValue(row.id),
            'company_name': row.companyName.trim(),
            'working_period': row.workingPeriod.trim(),
            'duties': row.duties.trim(),
            'supervisor': row.supervisor.trim(),
          },
      ];
    }

    // Optional empty strings / lists are omitted. Required fields stay.
    const requiredKeys = {
      'name',
      'email',
      'phone',
      'cnic',
      'department_id',
      'designation_id',
      'gender',
      'blood_group',
      'dob',
      'religion',
      'emergency_contact',
      'emergency_contact_name',
      'emergency_contact_relationship',
      'present_address',
      'permanent_address',
      'joining_date',
      'salary',
      'salary_type',
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

  static String _resolvedId(
    String id,
    String name,
    List<EditEmployeeOptionEntity> options,
  ) {
    if (id.trim().isNotEmpty) return id.trim();
    return _idForName(name, options);
  }

  static String _idForName(
    String name,
    List<EditEmployeeOptionEntity> options,
  ) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '';
    final wanted = trimmed.toLowerCase();
    for (final option in options) {
      if (option.name.trim().toLowerCase() == wanted) return option.id;
    }
    return '';
  }

  static void _putId(Map<String, dynamic> body, String key, String id) {
    final value = EditEmployeeJsonHelpers.idValue(id);
    if (value != null) body[key] = value;
  }
}
