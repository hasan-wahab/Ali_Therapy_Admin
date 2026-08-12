import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employee_entity.dart';

// ============================================================
// EMPLOYEE CARD MAPPER
// ------------------------------------------------------------
// Maps API EmployeeEntity → fields the card needs.
// Missing API fields stay hardcoded (do not remove from UI).
// ============================================================

class EmployeeCardMapper {
  EmployeeCardMapper._();

  /// Hardcoded — API has no roles list.
  static const List<String> hardcodedRoles = ['Employee'];

  /// Hardcoded — API has no tenure field.
  static const String hardcodedTenure = '-';

  /// Hardcoded — API only has created_by id, not a display name.
  static const String hardcodedCreatedBy = 'System';

  /// Hardcoded — API has is_login, not employment Active/Inactive.
  static const bool hardcodedIsActive = true;

  static String name(EmployeeEntity e) => e.name;

  static String email(EmployeeEntity e) => e.email;

  static String phone(EmployeeEntity e) => e.phone;

  static String cnic(EmployeeEntity e) => e.cnic;

  /// Prefer username (DAT-xxx); fall back to id.
  static String employeeId(EmployeeEntity e) {
    if (e.username != '_') return e.username;
    return e.id;
  }

  static String joinedDate(EmployeeEntity e) {
    final parsed = Helpers.tryParseDate(e.createdAt);
    if (parsed == null) return e.createdAt;
    return Helpers.formatDate(parsed, pattern: 'MMM dd, yyyy');
  }

  /// Clinic · Shift — same style as the old sample cards.
  static String shift(EmployeeEntity e) {
    final clinicName = _optionalName(e.clinic?.name);
    final shiftName = _optionalName(e.shift?.name);

    if (clinicName != null && shiftName != null) {
      return '$clinicName · $shiftName';
    }
    if (shiftName != null) return shiftName;
    if (clinicName != null) return clinicName;
    return '_';
  }

  /// Null when missing so avatar can show placeholder.
  static String? imageUrl(EmployeeEntity e) {
    if (e.profilePicture == '_') return null;
    return e.profilePicture;
  }

  static String? _optionalName(String? value) {
    if (value == null || value == '_' || value.trim().isEmpty) return null;
    return value;
  }
}
