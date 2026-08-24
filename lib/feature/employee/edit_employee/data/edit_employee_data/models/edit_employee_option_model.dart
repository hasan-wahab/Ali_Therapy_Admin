import '../../../domain/edit_employee_domain/entities/edit_employee_option_entity.dart';
import 'edit_employee_json_helpers.dart';

// ============================================================
// EDIT EMPLOYEE OPTION MODEL (Data)
// ============================================================

class EditEmployeeOptionModel extends EditEmployeeOptionEntity {
  const EditEmployeeOptionModel({
    required super.id,
    required super.name,
  });

  factory EditEmployeeOptionModel.fromJson(Map<String, dynamic> json) {
    return EditEmployeeOptionModel(
      id: EditEmployeeJsonHelpers.idOf(json, const ['id', 'value']),
      name: EditEmployeeJsonHelpers.fieldOf(json, const ['name', 'title', 'label']),
    );
  }

  static List<EditEmployeeOptionModel> listFromJson(dynamic raw) {
    final list = EditEmployeeJsonHelpers.listOrEmpty(raw);
    final options = <EditEmployeeOptionModel>[];
    for (final item in list) {
      if (item is String || item is num) {
        final name = EditEmployeeJsonHelpers.field(item);
        if (name.isEmpty) continue;
        options.add(EditEmployeeOptionModel(id: name, name: name));
        continue;
      }
      final map = EditEmployeeJsonHelpers.mapOrNull(item);
      if (map == null) continue;
      final option = EditEmployeeOptionModel.fromJson(map);
      if (option.name.isEmpty && option.id.isEmpty) continue;
      options.add(
        EditEmployeeOptionModel(
          id: option.id.isEmpty ? option.name : option.id,
          name: option.name.isEmpty ? option.id : option.name,
        ),
      );
    }
    return options;
  }

  EditEmployeeOptionEntity toEntity() =>
      EditEmployeeOptionEntity(id: id, name: name);
}
