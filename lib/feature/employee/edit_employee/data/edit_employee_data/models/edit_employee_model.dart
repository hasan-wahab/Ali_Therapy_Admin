import '../../../domain/edit_employee_domain/entities/edit_employee_document_entry.dart';
import '../../../domain/edit_employee_domain/entities/edit_employee_education_entry.dart';
import '../../../domain/edit_employee_domain/entities/edit_employee_entity.dart';
import '../../../domain/edit_employee_domain/entities/edit_employee_experience_entry.dart';
import '../../../domain/edit_employee_domain/entities/edit_employee_form_entity.dart';
import '../../../domain/edit_employee_domain/entities/edit_employee_option_entity.dart';
import '../../../domain/edit_employee_domain/entities/edit_employee_options_entity.dart';
import 'edit_employee_json_helpers.dart';
import 'edit_employee_option_model.dart';

// ============================================================
// EDIT EMPLOYEE MODEL (Data)
// ------------------------------------------------------------
// Parses GET employees/{id}/edit or GET employees/{id}.
// Accepts:
//   { data: { employee: {...}, clinics: [...] } }
//   { data: { ...employee fields..., clinics: [...] } }
//   { ...employee fields... }
// ============================================================

class EditEmployeeModel extends EditEmployeeEntity {
  const EditEmployeeModel({
    required super.form,
    required super.options,
  });

  factory EditEmployeeModel.fromResponse(
    dynamic raw, {
    Map<String, dynamic>? filtersMap,
  }) {
    final root = EditEmployeeJsonHelpers.mapOrNull(raw) ?? <String, dynamic>{};
    final data = EditEmployeeJsonHelpers.mapOrNull(root['data']) ?? root;
    final employee = EditEmployeeJsonHelpers.mapOrNull(data['employee']) ??
        EditEmployeeJsonHelpers.mapOrNull(data['user']) ??
        data;

    final fromPayload = _optionsFromMap(data);
    final fromFilters = _optionsFromMap(filtersMap ?? const {});
    final options = _mergeOptions(fromPayload, fromFilters);

    return EditEmployeeModel(
      form: _formFromJson(employee, options),
      options: options,
    );
  }

  EditEmployeeEntity toEntity() =>
      EditEmployeeEntity(form: form, options: options);

  static EditEmployeeFormEntity _formFromJson(
    Map<String, dynamic> json,
    EditEmployeeOptionsEntity options,
  ) {
    final clinicId = EditEmployeeJsonHelpers.relationId(
      json,
      idKeys: const ['clinic_id', 'clinicId'],
      objectKey: 'clinic',
    );
    final roomId = EditEmployeeJsonHelpers.relationId(
      json,
      idKeys: const ['room_id', 'roomId'],
      objectKey: 'room',
    );
    final departmentId = EditEmployeeJsonHelpers.relationId(
      json,
      idKeys: const ['department_id', 'departmentId'],
      objectKey: 'department',
    );
    final designationId = EditEmployeeJsonHelpers.relationId(
      json,
      idKeys: const ['designation_id', 'designationId'],
      objectKey: 'designation',
    );
    final shiftId = EditEmployeeJsonHelpers.relationId(
      json,
      idKeys: const ['shift_id', 'shiftId'],
      objectKey: 'shift',
    );

    final clinicName = _nameOrLookup(
      EditEmployeeJsonHelpers.fieldOf(json, const ['clinic', 'clinic_name']),
      clinicId,
      options.clinics,
    );
    final roomName = _nameOrLookup(
      EditEmployeeJsonHelpers.fieldOf(json, const ['room', 'room_name']),
      roomId,
      options.rooms,
    );
    final departmentName = _nameOrLookup(
      EditEmployeeJsonHelpers.fieldOf(json, const [
        'department',
        'department_name',
      ]),
      departmentId,
      options.departments,
    );
    final designationName = _nameOrLookup(
      EditEmployeeJsonHelpers.fieldOf(json, const [
        'designation',
        'designation_name',
      ]),
      designationId,
      options.designations,
    );
    final shiftName = _nameOrLookup(
      EditEmployeeJsonHelpers.fieldOf(json, const ['shift', 'shift_name']),
      shiftId,
      options.shifts,
    );

    final roles = _rolesFromJson(json, options.roles);

    return EditEmployeeFormEntity(
      id: EditEmployeeJsonHelpers.idOf(json, const ['id']),
      name: EditEmployeeJsonHelpers.fieldOf(json, const ['name', 'full_name']),
      employeeCode: EditEmployeeJsonHelpers.fieldOf(json, const [
        'username',
        'user_name',
        'employee_id',
        'employeeId',
      ]),
      email: EditEmployeeJsonHelpers.fieldOf(json, const ['email']),
      clinicId: clinicId.isEmpty
          ? _idForName(clinicName, options.clinics)
          : clinicId,
      clinicName: clinicName,
      roomId: roomId.isEmpty ? _idForName(roomName, options.rooms) : roomId,
      roomName: roomName,
      roleIds: roles.ids,
      roleNames: roles.names,
      allowLogin: EditEmployeeJsonHelpers.flag(
        json['allow_login'] ?? json['allowLogin'] ?? json['is_login'],
      ),
      imageUrl: EditEmployeeJsonHelpers.fieldOf(json, const [
        'profile_picture',
        'profilePicture',
        'image_url',
        'imageUrl',
        'image',
        'avatar',
      ]),
      departmentId: departmentId.isEmpty
          ? _idForName(departmentName, options.departments)
          : departmentId,
      departmentName: departmentName,
      designationId: designationId.isEmpty
          ? _idForName(designationName, options.designations)
          : designationId,
      designationName: designationName,
      shiftId:
          shiftId.isEmpty ? _idForName(shiftName, options.shifts) : shiftId,
      shiftName: shiftName,
      biometricId: EditEmployeeJsonHelpers.fieldOf(json, const [
        'biometric_id',
        'biometricId',
        'biometric_device_user_id',
      ]),
      gender: EditEmployeeJsonHelpers.genderDisplay(
        EditEmployeeJsonHelpers.fieldOf(json, const ['gender']),
      ),
      phone: EditEmployeeJsonHelpers.fieldOf(json, const ['phone', 'mobile']),
      cnic: EditEmployeeJsonHelpers.fieldOf(json, const ['cnic']),
      dateOfBirth: EditEmployeeJsonHelpers.displayDate(
        EditEmployeeJsonHelpers.fieldOf(json, const [
          'date_of_birth',
          'dateOfBirth',
          'dob',
        ]),
      ),
      joiningDate: EditEmployeeJsonHelpers.displayDate(
        EditEmployeeJsonHelpers.fieldOf(json, const [
          'joining_date',
          'joiningDate',
          'joined_date',
        ]),
      ),
      emergencyName: EditEmployeeJsonHelpers.fieldOf(json, const [
        'emergency_contact_name',
        'emergency_name',
        'emergencyName',
      ]),
      emergencyRelationship: EditEmployeeJsonHelpers.fieldOf(json, const [
        'emergency_contact_relationship',
        'emergency_relationship',
        'emergencyRelationship',
      ]),
      emergencyPhone: EditEmployeeJsonHelpers.fieldOf(json, const [
        'emergency_contact',
        'emergency_phone',
        'emergencyPhone',
      ]),
      religion: EditEmployeeJsonHelpers.fieldOf(json, const ['religion']),
      bloodGroup: EditEmployeeJsonHelpers.fieldOf(json, const [
        'blood_group',
        'bloodGroup',
      ]),
      district: EditEmployeeJsonHelpers.fieldOf(json, const ['district']),
      experienceYears: EditEmployeeJsonHelpers.fieldOf(json, const [
        'experience',
        'experience_years',
        'experienceYears',
      ]),
      salaryType: EditEmployeeJsonHelpers.salaryTypeDisplay(
        EditEmployeeJsonHelpers.fieldOf(json, const [
          'salary_type',
          'salaryType',
        ]),
      ),
      salary: EditEmployeeJsonHelpers.fieldOf(json, const [
        'salary',
        'salary_amount',
      ]),
      presentAddress: EditEmployeeJsonHelpers.fieldOf(json, const [
        'present_address',
        'presentAddress',
      ]),
      permanentAddress: EditEmployeeJsonHelpers.fieldOf(json, const [
        'permanent_address',
        'permanentAddress',
      ]),
      biography: EditEmployeeJsonHelpers.fieldOf(json, const ['biography']),
      bankName: EditEmployeeJsonHelpers.fieldOf(json, const [
        'banck_name',
        'bank_name',
        'bank',
      ]),
      branch: EditEmployeeJsonHelpers.fieldOf(json, const [
        'banck_branch',
        'branch',
      ]),
      branchCode: EditEmployeeJsonHelpers.fieldOf(json, const [
        'banck_branch_code',
        'branch_code',
        'branchCode',
      ]),
      accountHolder: EditEmployeeJsonHelpers.fieldOf(json, const [
        'banck_account_holder',
        'account_holder',
        'accountHolder',
      ]),
      accountNumber: EditEmployeeJsonHelpers.fieldOf(json, const [
        'banck_account_number',
        'account_number',
        'accountNumber',
      ]),
      iban: EditEmployeeJsonHelpers.fieldOf(json, const [
        'banck_iban_number',
        'iban',
      ]),
      documents: _documentsFromJson(
        json['documents'] ?? json['employee_documents'],
      ),
      educations: _educationsFromJson(
        json['educations'] ?? json['education'] ?? json['employee_educations'],
      ),
      experiences: _experiencesFromJson(
        json['experience_rows'] ??
            json['experiences'] ??
            json['experience_list'] ??
            json['employee_experiences'],
      ),
    );
  }

  static List<EditEmployeeDocumentEntry> _documentsFromJson(dynamic raw) {
    final result = <EditEmployeeDocumentEntry>[];
    for (final item in EditEmployeeJsonHelpers.listOrEmpty(raw)) {
      final map = EditEmployeeJsonHelpers.mapOrNull(item);
      if (map == null) continue;
      result.add(
        EditEmployeeDocumentEntry(
          id: EditEmployeeJsonHelpers.idOf(map, const ['id']),
          title: EditEmployeeJsonHelpers.fieldOf(map, const [
            'doc_title',
            'docTitle',
            'title',
          ]),
          description: EditEmployeeJsonHelpers.fieldOf(map, const [
            'doc_description',
            'docDescription',
            'description',
          ]),
          expiry: EditEmployeeJsonHelpers.displayDate(
            EditEmployeeJsonHelpers.fieldOf(map, const [
              'doc_expiry',
              'docExpiry',
              'expiry',
            ]),
          ),
        ),
      );
    }
    if (result.isEmpty) {
      return const [EditEmployeeDocumentEntry()];
    }
    return result;
  }

  static List<EditEmployeeEducationEntry> _educationsFromJson(dynamic raw) {
    final result = <EditEmployeeEducationEntry>[];
    for (final item in EditEmployeeJsonHelpers.listOrEmpty(raw)) {
      final map = EditEmployeeJsonHelpers.mapOrNull(item);
      if (map == null) continue;
      result.add(
        EditEmployeeEducationEntry(
          id: EditEmployeeJsonHelpers.idOf(map, const ['id']),
          degree: EditEmployeeJsonHelpers.fieldOf(map, const ['degree']),
          university: EditEmployeeJsonHelpers.fieldOf(map, const [
            'university',
          ]),
          cgpa: EditEmployeeJsonHelpers.fieldOf(map, const ['cgpa']),
          comments: EditEmployeeJsonHelpers.fieldOf(map, const ['comments']),
        ),
      );
    }
    if (result.isEmpty) {
      return const [EditEmployeeEducationEntry()];
    }
    return result;
  }

  static List<EditEmployeeExperienceEntry> _experiencesFromJson(dynamic raw) {
    final result = <EditEmployeeExperienceEntry>[];
    for (final item in EditEmployeeJsonHelpers.listOrEmpty(raw)) {
      final map = EditEmployeeJsonHelpers.mapOrNull(item);
      if (map == null) continue;
      result.add(
        EditEmployeeExperienceEntry(
          id: EditEmployeeJsonHelpers.idOf(map, const ['id']),
          companyName: EditEmployeeJsonHelpers.fieldOf(map, const [
            'company_name',
            'companyName',
            'company',
          ]),
          workingPeriod: EditEmployeeJsonHelpers.fieldOf(map, const [
            'working_period',
            'workingPeriod',
            'period',
          ]),
          duties: EditEmployeeJsonHelpers.fieldOf(map, const ['duties']),
          supervisor: EditEmployeeJsonHelpers.fieldOf(map, const [
            'supervisor',
          ]),
        ),
      );
    }
    if (result.isEmpty) {
      return const [EditEmployeeExperienceEntry()];
    }
    return result;
  }

  static ({List<String> ids, List<String> names}) _rolesFromJson(
    Map<String, dynamic> json,
    List<EditEmployeeOptionEntity> roleOptions,
  ) {
    final ids = <String>[];
    final names = <String>[];

    final rawIds = json['role_ids'] ?? json['roleIds'];
    for (final item in EditEmployeeJsonHelpers.listOrEmpty(rawIds)) {
      final id = EditEmployeeJsonHelpers.field(item);
      if (id.isEmpty) continue;
      ids.add(id);
      names.add(_nameOrLookup('', id, roleOptions));
    }

    final rawRoles = json['roles'] ?? json['role'];
    if (rawRoles is String) {
      final name = EditEmployeeJsonHelpers.field(rawRoles);
      if (name.isNotEmpty && !names.contains(name)) {
        names.add(name);
        final id = _idForName(name, roleOptions);
        if (id.isNotEmpty && !ids.contains(id)) ids.add(id);
      }
    } else {
      for (final item in EditEmployeeJsonHelpers.listOrEmpty(rawRoles)) {
        if (item is String || item is num) {
          final name = EditEmployeeJsonHelpers.field(item);
          if (name.isEmpty || names.contains(name)) continue;
          names.add(name);
          final id = _idForName(name, roleOptions);
          if (id.isNotEmpty && !ids.contains(id)) ids.add(id);
          continue;
        }
        final map = EditEmployeeJsonHelpers.mapOrNull(item);
        if (map == null) continue;
        final id = EditEmployeeJsonHelpers.idOf(map, const ['id']);
        final name = EditEmployeeJsonHelpers.fieldOf(map, const [
          'name',
          'title',
        ]);
        if (id.isNotEmpty && !ids.contains(id)) ids.add(id);
        if (name.isNotEmpty && !names.contains(name)) {
          names.add(name);
        } else if (id.isNotEmpty) {
          final lookedUp = _nameOrLookup('', id, roleOptions);
          if (lookedUp.isNotEmpty && !names.contains(lookedUp)) {
            names.add(lookedUp);
          }
        }
      }
    }

    return (ids: ids, names: names);
  }

  static EditEmployeeOptionsEntity _optionsFromMap(Map<String, dynamic> json) {
    final nested = EditEmployeeJsonHelpers.mapOrNull(json['filters']) ?? json;
    return EditEmployeeOptionsEntity(
      clinics: EditEmployeeOptionModel.listFromJson(
        nested['clinics'] ?? json['clinics'],
      ),
      rooms: EditEmployeeOptionModel.listFromJson(
        nested['rooms'] ?? json['rooms'],
      ),
      roles: EditEmployeeOptionModel.listFromJson(
        nested['roles'] ?? json['roles'],
      ),
      departments: EditEmployeeOptionModel.listFromJson(
        nested['departments'] ?? json['departments'],
      ),
      designations: EditEmployeeOptionModel.listFromJson(
        nested['designations'] ?? json['designations'],
      ),
      shifts: EditEmployeeOptionModel.listFromJson(
        nested['shifts'] ?? json['shifts'],
      ),
    );
  }

  static EditEmployeeOptionsEntity _mergeOptions(
    EditEmployeeOptionsEntity a,
    EditEmployeeOptionsEntity b,
  ) {
    // Filters catalog (b) wins — payload "roles" can be the assigned list.
    return EditEmployeeOptionsEntity(
      clinics: b.clinics.isNotEmpty ? b.clinics : a.clinics,
      rooms: b.rooms.isNotEmpty ? b.rooms : a.rooms,
      roles: b.roles.isNotEmpty ? b.roles : a.roles,
      departments: b.departments.isNotEmpty ? b.departments : a.departments,
      designations:
          b.designations.isNotEmpty ? b.designations : a.designations,
      shifts: b.shifts.isNotEmpty ? b.shifts : a.shifts,
    );
  }

  static String _nameOrLookup(
    String name,
    String id,
    List<EditEmployeeOptionEntity> options,
  ) {
    if (name.isNotEmpty) return name;
    if (id.isEmpty) return '';
    for (final option in options) {
      if (option.id == id) return option.name;
    }
    return '';
  }

  static String _idForName(
    String name,
    List<EditEmployeeOptionEntity> options,
  ) {
    if (name.isEmpty) return '';
    for (final option in options) {
      if (option.name == name) return option.id;
    }
    return '';
  }
}
