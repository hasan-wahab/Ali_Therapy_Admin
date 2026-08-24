import 'package:equatable/equatable.dart';

import 'edit_employee_form_entity.dart';
import 'edit_employee_options_entity.dart';

// ============================================================
// EDIT EMPLOYEE ENTITY (Domain)
// ------------------------------------------------------------
// GET employees/{id}/edit (or show) — form values + dropdowns.
// ============================================================

class EditEmployeeEntity extends Equatable {
  const EditEmployeeEntity({
    required this.form,
    required this.options,
  });

  final EditEmployeeFormEntity form;
  final EditEmployeeOptionsEntity options;

  @override
  List<Object?> get props => [form, options];
}
