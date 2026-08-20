import '../../../domain/all_employees_domain/entities/employee_filter_option_entity.dart';
import 'employee_json_helpers.dart';

// ============================================================
// EMPLOYEE FILTER OPTION MODEL (Data)
// ------------------------------------------------------------
// Parses one filter item:
//   { "id": 18, "name": "Accountant" }
// Status:
//   { "id": "1", "name": "Active", "value": 1 }
// ============================================================

class EmployeeFilterOptionModel extends EmployeeFilterOptionEntity {
  const EmployeeFilterOptionModel({
    required super.id,
    required super.name,
    super.value,
  });

  factory EmployeeFilterOptionModel.fromJson(Map<String, dynamic> json) {
    return EmployeeFilterOptionModel(
      id: EmployeeJsonHelpers.text(json['id']),
      name: EmployeeJsonHelpers.text(json['name']),
      value: _intOrNull(json['value']),
    );
  }

  /// Parse a JSON array of { id, name, value? }.
  static List<EmployeeFilterOptionModel> listFromJson(dynamic rawList) {
    final list = EmployeeJsonHelpers.listOrEmpty(rawList);
    final options = <EmployeeFilterOptionModel>[];

    for (final item in list) {
      final map = EmployeeJsonHelpers.mapOrNull(item);
      if (map == null) continue;
      options.add(EmployeeFilterOptionModel.fromJson(map));
    }

    return options;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (value != null) 'value': value,
    };
  }

  EmployeeFilterOptionEntity toEntity() {
    return EmployeeFilterOptionEntity(
      id: id,
      name: name,
      value: value,
    );
  }

  static int? _intOrNull(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString().trim());
  }
}
