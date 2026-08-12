// ============================================================
// EDIT EMPLOYEE STEP
// ------------------------------------------------------------
// Section steps shown one at a time (Next / Back).
// ============================================================

enum EditEmployeeStep {
  userDetails,
  details,
  bankDetails,
  documents,
  education,
  experience,
}

extension EditEmployeeStepX on EditEmployeeStep {
  String get title {
    switch (this) {
      case EditEmployeeStep.userDetails:
        return 'User Details';
      case EditEmployeeStep.details:
        return 'Details';
      case EditEmployeeStep.bankDetails:
        return 'Bank Details';
      case EditEmployeeStep.documents:
        return 'Documents';
      case EditEmployeeStep.education:
        return 'Education';
      case EditEmployeeStep.experience:
        return 'Experience';
    }
  }

  String get subtitle {
    switch (this) {
      case EditEmployeeStep.userDetails:
        return 'Login & profile';
      case EditEmployeeStep.details:
        return 'Personal info';
      case EditEmployeeStep.bankDetails:
        return 'Payroll accounts';
      case EditEmployeeStep.documents:
        return 'Upload files';
      case EditEmployeeStep.education:
        return 'Degrees & notes';
      case EditEmployeeStep.experience:
        return 'Previous roles';
    }
  }

  bool get isFirst => this == EditEmployeeStep.userDetails;

  bool get isLast => this == EditEmployeeStep.experience;

  EditEmployeeStep? get previous {
    final index = EditEmployeeStep.values.indexOf(this);
    if (index <= 0) return null;
    return EditEmployeeStep.values[index - 1];
  }

  EditEmployeeStep? get next {
    final index = EditEmployeeStep.values.indexOf(this);
    if (index >= EditEmployeeStep.values.length - 1) return null;
    return EditEmployeeStep.values[index + 1];
  }
}
