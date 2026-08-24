import 'package:equatable/equatable.dart';

// ============================================================
// EDIT EMPLOYEE EXPERIENCE ENTRY (Domain)
// ============================================================

class EditEmployeeExperienceEntry extends Equatable {
  const EditEmployeeExperienceEntry({
    this.id = '',
    this.companyName = '',
    this.workingPeriod = '',
    this.duties = '',
    this.supervisor = '',
  });

  final String id;
  final String companyName;
  final String workingPeriod;
  final String duties;
  final String supervisor;

  bool get isEmpty =>
      companyName.trim().isEmpty &&
      workingPeriod.trim().isEmpty &&
      duties.trim().isEmpty &&
      supervisor.trim().isEmpty;

  @override
  List<Object?> get props =>
      [id, companyName, workingPeriod, duties, supervisor];
}
