import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_document_entry.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_education_entry.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_experience_entry.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_form_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_step.dart';

// ============================================================
// EDIT EMPLOYEE FORM CONTROLLERS
// ------------------------------------------------------------
// Holds field values across steps so Submit can read everything.
// ============================================================

class EditDocumentEntryControllers {
  EditDocumentEntryControllers({
    this.id = '',
    String title = '',
    String description = '',
    this.expiry = '',
    this.filePath = '',
    this.fileName = '',
    this.fileBytes = const [],
  })  : title = TextEditingController(text: title),
        description = TextEditingController(text: description);

  String id;
  final TextEditingController title;
  final TextEditingController description;
  String expiry;
  String filePath;
  String fileName;
  List<int> fileBytes;

  void dispose() {
    title.dispose();
    description.dispose();
  }
}

class EditEducationEntryControllers {
  EditEducationEntryControllers({
    this.id = '',
    String degree = '',
    String university = '',
    String cgpa = '',
    String comments = '',
  })  : degree = TextEditingController(text: degree),
        university = TextEditingController(text: university),
        cgpa = TextEditingController(text: cgpa),
        comments = TextEditingController(text: comments);

  String id;
  final TextEditingController degree;
  final TextEditingController university;
  final TextEditingController cgpa;
  final TextEditingController comments;

  void dispose() {
    degree.dispose();
    university.dispose();
    cgpa.dispose();
    comments.dispose();
  }
}

class EditExperienceEntryControllers {
  EditExperienceEntryControllers({
    this.id = '',
    String company = '',
    String period = '',
    String duties = '',
    String supervisor = '',
  })  : company = TextEditingController(text: company),
        period = TextEditingController(text: period),
        duties = TextEditingController(text: duties),
        supervisor = TextEditingController(text: supervisor);

  String id;
  final TextEditingController company;
  final TextEditingController period;
  final TextEditingController duties;
  final TextEditingController supervisor;

  void dispose() {
    company.dispose();
    period.dispose();
    duties.dispose();
    supervisor.dispose();
  }
}

class EditEmployeeFormControllers extends ChangeNotifier {
  EditEmployeeFormControllers()
      : name = TextEditingController(),
        employeeCode = TextEditingController(),
        email = TextEditingController(),
        password = TextEditingController(),
        biometricId = TextEditingController(),
        phone = TextEditingController(),
        cnic = TextEditingController(),
        emergencyName = TextEditingController(),
        emergencyRelationship = TextEditingController(),
        emergencyPhone = TextEditingController(),
        religion = TextEditingController(),
        bloodGroup = TextEditingController(),
        district = TextEditingController(),
        experienceYears = TextEditingController(),
        salary = TextEditingController(),
        presentAddress = TextEditingController(),
        permanentAddress = TextEditingController(),
        biography = TextEditingController(),
        bankName = TextEditingController(),
        branch = TextEditingController(),
        branchCode = TextEditingController(),
        accountHolder = TextEditingController(),
        accountNumber = TextEditingController(),
        iban = TextEditingController() {
    _bindClearError(name, nameKey);
    _bindClearError(email, emailKey);
    _bindClearError(password, passwordKey);
    _bindClearError(phone, phoneKey);
    _bindClearError(cnic, cnicKey);
    _bindClearError(emergencyName, emergencyNameKey);
    _bindClearError(emergencyRelationship, emergencyRelationshipKey);
    _bindClearError(emergencyPhone, emergencyPhoneKey);
    _bindClearError(religion, religionKey);
    _bindClearError(bloodGroup, bloodGroupKey);
    _bindClearError(salary, salaryKey);
    _bindClearError(presentAddress, presentAddressKey);
    _bindClearError(permanentAddress, permanentAddressKey);
  }

  static const nameKey = 'name';
  static const emailKey = 'email';
  static const passwordKey = 'password';
  static const departmentKey = 'department';
  static const designationKey = 'designation';
  static const genderKey = 'gender';
  static const phoneKey = 'phone';
  static const cnicKey = 'cnic';
  static const dateOfBirthKey = 'dateOfBirth';
  static const joiningDateKey = 'joiningDate';
  static const emergencyNameKey = 'emergencyName';
  static const emergencyRelationshipKey = 'emergencyRelationship';
  static const emergencyPhoneKey = 'emergencyPhone';
  static const religionKey = 'religion';
  static const bloodGroupKey = 'bloodGroup';
  static const salaryTypeKey = 'salaryType';
  static const salaryKey = 'salary';
  static const presentAddressKey = 'presentAddress';
  static const permanentAddressKey = 'permanentAddress';

  String employeeId = '';
  String imageUrl = '';
  String profilePicturePath = '';
  String profilePictureName = '';
  List<int> profilePictureBytes = const [];
  Set<String> invalidFields = {};

  final TextEditingController name;
  final TextEditingController employeeCode;
  final TextEditingController email;
  final TextEditingController password;

  String clinicName = '';
  String clinicId = '';
  String roomName = '';
  String roomId = '';
  List<String> roleNames = [];
  List<String> roleIds = [];
  bool allowLogin = true;

  String departmentName = '';
  String departmentId = '';
  String designationName = '';
  String designationId = '';
  String shiftName = '';
  String shiftId = '';
  String gender = '';
  String salaryType = '';
  String dateOfBirth = '';
  String joiningDate = '';

  final TextEditingController biometricId;
  final TextEditingController phone;
  final TextEditingController cnic;
  final TextEditingController emergencyName;
  final TextEditingController emergencyRelationship;
  final TextEditingController emergencyPhone;
  final TextEditingController religion;
  final TextEditingController bloodGroup;
  final TextEditingController district;
  final TextEditingController experienceYears;
  final TextEditingController salary;
  final TextEditingController presentAddress;
  final TextEditingController permanentAddress;
  final TextEditingController biography;
  final TextEditingController bankName;
  final TextEditingController branch;
  final TextEditingController branchCode;
  final TextEditingController accountHolder;
  final TextEditingController accountNumber;
  final TextEditingController iban;

  final List<EditDocumentEntryControllers> documents = [];
  final List<EditEducationEntryControllers> educations = [];
  final List<EditExperienceEntryControllers> experiences = [];

  void fillFrom(EditEmployeeFormEntity form) {
    employeeId = form.id;
    imageUrl = form.imageUrl;
    profilePicturePath = '';
    profilePictureName = '';
    profilePictureBytes = const [];
    name.text = form.name;
    employeeCode.text = form.employeeCode;
    email.text = form.email;
    password.text = '';
    clinicName = form.clinicName;
    clinicId = form.clinicId;
    roomName = form.roomName;
    roomId = form.roomId;
    roleNames = List<String>.from(form.roleNames);
    roleIds = List<String>.from(form.roleIds);
    allowLogin = form.allowLogin;
    departmentName = form.departmentName;
    departmentId = form.departmentId;
    designationName = form.designationName;
    designationId = form.designationId;
    shiftName = form.shiftName;
    shiftId = form.shiftId;
    gender = form.gender;
    salaryType = form.salaryType;
    dateOfBirth = form.dateOfBirth;
    joiningDate = form.joiningDate;
    biometricId.text = form.biometricId;
    phone.text = form.phone;
    cnic.text = form.cnic;
    emergencyName.text = form.emergencyName;
    emergencyRelationship.text = form.emergencyRelationship;
    emergencyPhone.text = form.emergencyPhone;
    religion.text = form.religion;
    bloodGroup.text = form.bloodGroup;
    district.text = form.district;
    experienceYears.text = form.experienceYears;
    salary.text = form.salary;
    presentAddress.text = form.presentAddress;
    permanentAddress.text = form.permanentAddress;
    biography.text = form.biography;
    bankName.text = form.bankName;
    branch.text = form.branch;
    branchCode.text = form.branchCode;
    accountHolder.text = form.accountHolder;
    accountNumber.text = form.accountNumber;
    iban.text = form.iban;

    _replaceDocuments(form.documents);
    _replaceEducations(form.educations);
    _replaceExperiences(form.experiences);
    invalidFields = {};
    notifyListeners();
  }

  bool isInvalid(String key) => invalidFields.contains(key);

  void _bindClearError(TextEditingController controller, String key) {
    controller.addListener(() => _clearError(key));
  }

  void _clearError(String key) {
    if (!invalidFields.contains(key)) return;
    invalidFields = {...invalidFields}..remove(key);
    notifyListeners();
  }

  void _setInvalid(Map<String, String> errors) {
    invalidFields = errors.keys.toSet();
    notifyListeners();
  }

  EditEmployeeFormEntity toForm() {
    return EditEmployeeFormEntity(
      id: employeeId,
      name: name.text,
      employeeCode: employeeCode.text,
      email: email.text,
      password: password.text,
      clinicId: clinicId,
      clinicName: clinicName,
      roomId: roomId,
      roomName: roomName,
      roleIds: List<String>.from(roleIds),
      roleNames: List<String>.from(roleNames),
      allowLogin: allowLogin,
      imageUrl: imageUrl,
      profilePicturePath: profilePicturePath,
      profilePictureName: profilePictureName,
      profilePictureBytes: List<int>.from(profilePictureBytes),
      departmentId: departmentId,
      departmentName: departmentName,
      designationId: designationId,
      designationName: designationName,
      shiftId: shiftId,
      shiftName: shiftName,
      biometricId: biometricId.text,
      gender: gender,
      phone: phone.text,
      cnic: cnic.text,
      dateOfBirth: dateOfBirth,
      joiningDate: joiningDate,
      emergencyName: emergencyName.text,
      emergencyRelationship: emergencyRelationship.text,
      emergencyPhone: emergencyPhone.text,
      religion: religion.text,
      bloodGroup: bloodGroup.text,
      district: district.text,
      experienceYears: experienceYears.text,
      salaryType: salaryType,
      salary: salary.text,
      presentAddress: presentAddress.text,
      permanentAddress: permanentAddress.text,
      biography: biography.text,
      bankName: bankName.text,
      branch: branch.text,
      branchCode: branchCode.text,
      accountHolder: accountHolder.text,
      accountNumber: accountNumber.text,
      iban: iban.text,
      documents: [
        for (final row in documents)
          EditEmployeeDocumentEntry(
            id: row.id,
            title: row.title.text,
            description: row.description.text,
            expiry: row.expiry,
          ),
      ],
      educations: [
        for (final row in educations)
          EditEmployeeEducationEntry(
            id: row.id,
            degree: row.degree.text,
            university: row.university.text,
            cgpa: row.cgpa.text,
            comments: row.comments.text,
          ),
      ],
      experiences: [
        for (final row in experiences)
          EditEmployeeExperienceEntry(
            id: row.id,
            companyName: row.company.text,
            workingPeriod: row.period.text,
            duties: row.duties.text,
            supervisor: row.supervisor.text,
          ),
      ],
    );
  }

  /// Docs required fields for the current step (Next / Submit).
  String? validateStep(EditEmployeeStep step) {
    switch (step) {
      case EditEmployeeStep.userDetails:
        return _validateUserDetails();
      case EditEmployeeStep.details:
        return _validateDetails();
      case EditEmployeeStep.bankDetails:
      case EditEmployeeStep.documents:
      case EditEmployeeStep.education:
      case EditEmployeeStep.experience:
        _setInvalid({});
        return null;
    }
  }

  /// All docs-required fields before POST /employees/update/{id}.
  String? validateForUpdate() {
    return validateStep(EditEmployeeStep.userDetails) ??
        validateStep(EditEmployeeStep.details);
  }

  String? _validateUserDetails() {
    final errors = <String, String>{};
    if (name.text.trim().isEmpty) {
      errors[nameKey] = 'Full name is required.';
    }
    if (email.text.trim().isEmpty) {
      errors[emailKey] = 'Email is required.';
    }
    final passwordValue = password.text.trim();
    if (passwordValue.isNotEmpty && passwordValue.length < 8) {
      errors[passwordKey] = 'Password must be at least 8 characters.';
    }
    _setInvalid(errors);
    return errors.isEmpty ? null : errors.values.first;
  }

  String? _validateDetails() {
    final errors = <String, String>{};
    if (departmentId.trim().isEmpty && departmentName.trim().isEmpty) {
      errors[departmentKey] = 'Department is required.';
    }
    if (designationId.trim().isEmpty && designationName.trim().isEmpty) {
      errors[designationKey] = 'Designation is required.';
    }
    final genderValue = gender.trim().toLowerCase();
    if (genderValue != 'male' && genderValue != 'female') {
      errors[genderKey] = 'Gender is required.';
    }
    if (phone.text.trim().isEmpty) {
      errors[phoneKey] = 'Phone is required.';
    }
    if (cnic.text.trim().isEmpty) {
      errors[cnicKey] = 'CNIC is required.';
    }
    if (dateOfBirth.trim().isEmpty) {
      errors[dateOfBirthKey] = 'Date of birth is required.';
    }
    if (joiningDate.trim().isEmpty) {
      errors[joiningDateKey] = 'Joining date is required.';
    }
    if (emergencyName.text.trim().isEmpty) {
      errors[emergencyNameKey] = 'Emergency contact name is required.';
    }
    if (emergencyRelationship.text.trim().isEmpty) {
      errors[emergencyRelationshipKey] =
          'Emergency contact relationship is required.';
    }
    if (emergencyPhone.text.trim().isEmpty) {
      errors[emergencyPhoneKey] = 'Emergency contact phone is required.';
    }
    if (religion.text.trim().isEmpty) {
      errors[religionKey] = 'Religion is required.';
    }
    if (bloodGroup.text.trim().isEmpty) {
      errors[bloodGroupKey] = 'Blood group is required.';
    }
    final salaryTypeValue = salaryType.trim().toLowerCase();
    if (salaryTypeValue != 'fixed' && salaryTypeValue != 'commission') {
      errors[salaryTypeKey] = 'Salary type is required.';
    }
    final salaryValue = salary.text.trim().replaceAll(',', '');
    if (salaryValue.isEmpty || num.tryParse(salaryValue) == null) {
      errors[salaryKey] = 'Salary amount is required.';
    }
    if (presentAddress.text.trim().isEmpty) {
      errors[presentAddressKey] = 'Present address is required.';
    }
    if (permanentAddress.text.trim().isEmpty) {
      errors[permanentAddressKey] = 'Permanent address is required.';
    }
    _setInvalid(errors);
    return errors.isEmpty ? null : errors.values.first;
  }

  void setProfilePicture({
    required String path,
    required String name,
    required List<int> bytes,
  }) {
    profilePicturePath = path;
    profilePictureName = name;
    profilePictureBytes = bytes;
    notifyListeners();
  }

  void setClinic(String? name, String id) {
    clinicName = name ?? '';
    clinicId = id;
    roomName = '';
    roomId = '';
    notifyListeners();
  }

  void setRoom(String? name, String id) {
    roomName = name ?? '';
    roomId = id;
    notifyListeners();
  }

  void setDepartment(String? name, String id) {
    departmentName = name ?? '';
    departmentId = id;
    invalidFields = {...invalidFields}..remove(departmentKey);
    notifyListeners();
  }

  void setDesignation(String? name, String id) {
    designationName = name ?? '';
    designationId = id;
    invalidFields = {...invalidFields}..remove(designationKey);
    notifyListeners();
  }

  void setShift(String? name, String id) {
    shiftName = name ?? '';
    shiftId = id;
    notifyListeners();
  }

  void setGender(String? value) {
    gender = value ?? '';
    invalidFields = {...invalidFields}..remove(genderKey);
    notifyListeners();
  }

  void setSalaryType(String? value) {
    salaryType = value ?? '';
    invalidFields = {...invalidFields}..remove(salaryTypeKey);
    notifyListeners();
  }

  void setDateOfBirth(String value) {
    dateOfBirth = value;
    invalidFields = {...invalidFields}..remove(dateOfBirthKey);
    notifyListeners();
  }

  void setJoiningDate(String value) {
    joiningDate = value;
    invalidFields = {...invalidFields}..remove(joiningDateKey);
    notifyListeners();
  }

  void setAllowLogin(String value) {
    allowLogin = value == 'Yes';
    notifyListeners();
  }

  void addRole(String name, String id) {
    if (name.isEmpty || roleNames.contains(name)) return;
    roleNames = [...roleNames, name];
    if (id.isNotEmpty && !roleIds.contains(id)) {
      roleIds = [...roleIds, id];
    }
    notifyListeners();
  }

  void removeRole(String name, String id) {
    roleNames = roleNames.where((item) => item != name).toList();
    if (id.isNotEmpty) {
      roleIds = roleIds.where((item) => item != id).toList();
    }
    notifyListeners();
  }

  void addDocument() {
    documents.add(EditDocumentEntryControllers());
    notifyListeners();
  }

  void removeDocument(int index) {
    if (documents.length <= 1) return;
    documents[index].dispose();
    documents.removeAt(index);
    notifyListeners();
  }

  void setDocumentExpiry(int index, String value) {
    if (index < 0 || index >= documents.length) return;
    documents[index].expiry = value;
    notifyListeners();
  }

  void setDocumentFile(
    int index, {
    required String path,
    required String name,
    required List<int> bytes,
  }) {
    if (index < 0 || index >= documents.length) return;
    documents[index].filePath = path;
    documents[index].fileName = name;
    documents[index].fileBytes = bytes;
    notifyListeners();
  }

  void addEducation() {
    educations.add(EditEducationEntryControllers());
    notifyListeners();
  }

  void removeEducation(int index) {
    if (educations.length <= 1) return;
    educations[index].dispose();
    educations.removeAt(index);
    notifyListeners();
  }

  void addExperience() {
    experiences.add(EditExperienceEntryControllers());
    notifyListeners();
  }

  void removeExperience(int index) {
    if (experiences.length <= 1) return;
    experiences[index].dispose();
    experiences.removeAt(index);
    notifyListeners();
  }

  void _replaceDocuments(List<EditEmployeeDocumentEntry> rows) {
    for (final row in documents) {
      row.dispose();
    }
    documents
      ..clear()
      ..addAll([
        for (final row in rows)
          EditDocumentEntryControllers(
            id: row.id,
            title: row.title,
            description: row.description,
            expiry: row.expiry,
          ),
      ]);
    if (documents.isEmpty) {
      documents.add(EditDocumentEntryControllers());
    }
  }

  void _replaceEducations(List<EditEmployeeEducationEntry> rows) {
    for (final row in educations) {
      row.dispose();
    }
    educations
      ..clear()
      ..addAll([
        for (final row in rows)
          EditEducationEntryControllers(
            id: row.id,
            degree: row.degree,
            university: row.university,
            cgpa: row.cgpa,
            comments: row.comments,
          ),
      ]);
    if (educations.isEmpty) {
      educations.add(EditEducationEntryControllers());
    }
  }

  void _replaceExperiences(List<EditEmployeeExperienceEntry> rows) {
    for (final row in experiences) {
      row.dispose();
    }
    experiences
      ..clear()
      ..addAll([
        for (final row in rows)
          EditExperienceEntryControllers(
            id: row.id,
            company: row.companyName,
            period: row.workingPeriod,
            duties: row.duties,
            supervisor: row.supervisor,
          ),
      ]);
    if (experiences.isEmpty) {
      experiences.add(EditExperienceEntryControllers());
    }
  }

  @override
  void dispose() {
    name.dispose();
    employeeCode.dispose();
    email.dispose();
    password.dispose();
    biometricId.dispose();
    phone.dispose();
    cnic.dispose();
    emergencyName.dispose();
    emergencyRelationship.dispose();
    emergencyPhone.dispose();
    religion.dispose();
    bloodGroup.dispose();
    district.dispose();
    experienceYears.dispose();
    salary.dispose();
    presentAddress.dispose();
    permanentAddress.dispose();
    biography.dispose();
    bankName.dispose();
    branch.dispose();
    branchCode.dispose();
    accountHolder.dispose();
    accountNumber.dispose();
    iban.dispose();
    for (final row in documents) {
      row.dispose();
    }
    for (final row in educations) {
      row.dispose();
    }
    for (final row in experiences) {
      row.dispose();
    }
    super.dispose();
  }
}
