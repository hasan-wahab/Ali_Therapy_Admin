import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employee_entity.dart';

// ============================================================
// EMPLOYEE CARD MAPPER
// ------------------------------------------------------------
// Maps API EmployeeEntity → fields the card shows.
// ============================================================

class EmployeeCardMapper {
  EmployeeCardMapper._();

  static String name(EmployeeEntity e) => e.name;

  static String email(EmployeeEntity e) => e.email;

  static String phone(EmployeeEntity e) => e.phone;

  static String cnic(EmployeeEntity e) => e.cnic;

  static String employeeId(EmployeeEntity e) => e.employeeId;

  static String joinedDate(EmployeeEntity e) {
    final parsed = Helpers.tryParseDate(e.joinedDate);
    if (parsed == null) return e.joinedDate;
    return Helpers.formatDate(parsed, pattern: 'MMM dd, yyyy');
  }

  static String tenure(EmployeeEntity e) => e.tenure;

  static List<String> roles(EmployeeEntity e) {
    if (e.roles.isEmpty) return const ['_'];
    return e.roles;
  }

  static String shift(EmployeeEntity e) => e.shift;

  static String createdBy(EmployeeEntity e) => e.createdBy;

  static bool isActive(EmployeeEntity e) => e.isActive;

  /// Null when missing so avatar can show placeholder.
  static String? imageUrl(EmployeeEntity e) {
    if (e.imageUrl == '_') return null;
    return e.imageUrl;
  }
}
