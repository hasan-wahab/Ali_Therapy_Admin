import '../../../domain/edit_employee_domain/entities/edit_employee_entity.dart';

// ============================================================
// EDITEMPLOYEE MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class EditEmployeeModel extends EditEmployeeEntity {
  const EditEmployeeModel({required super.id});

  factory EditEmployeeModel.fromJson(Map<String, dynamic> json) {
    return EditEmployeeModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  EditEmployeeEntity toEntity() => EditEmployeeEntity(id: id);
}
