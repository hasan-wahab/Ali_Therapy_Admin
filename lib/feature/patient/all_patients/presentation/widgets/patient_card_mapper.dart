import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/domain/all_patients_domain/entities/patient_entity.dart';

// ============================================================
// PATIENT CARD MAPPER
// ------------------------------------------------------------
// Maps API PatientEntity → fields the card shows.
// Missing values become "_" so the label still appears.
// ============================================================

class PatientCardMapper {
  PatientCardMapper._();

  static const String empty = '_';

  static final NumberFormat _moneyWhole = NumberFormat('#,##0', 'en_US');
  static final NumberFormat _moneyDecimal = NumberFormat('#,##0.00', 'en_US');

  static String display(String value) {
    final text = value.trim();
    if (text.isEmpty || text.toLowerCase() == 'n/a') return empty;
    return text;
  }

  static String titled(String value) {
    final text = display(value);
    if (text == empty) return empty;
    return Helpers.titleCase(text);
  }

  static String name(PatientEntity e) => titled(e.name);

  static String cnic(PatientEntity e) => display(e.cnic);

  static String patientId(PatientEntity e) => display(e.id);

  static String problems(PatientEntity e) {
    if (e.problems.isEmpty) return empty;
    return e.problems.map(Helpers.titleCase).join(', ');
  }

  static String insurance(PatientEntity e) => titled(e.insurance);

  static String pkr(double value) {
    if (value == value.roundToDouble()) {
      return 'PKR ${_moneyWhole.format(value)}';
    }
    return 'PKR ${_moneyDecimal.format(value)}';
  }

  static String totalBilled(PatientEntity e) => pkr(e.totalBilled);

  static String paid(PatientEntity e) => pkr(e.paid);

  static String discount(PatientEntity e) => pkr(e.discount);

  static String insuranceAmount(PatientEntity e) => pkr(e.insuranceAmount);

  static String remaining(PatientEntity e) => pkr(e.remaining);

  static String createdBy(PatientEntity e) => titled(e.createdBy);

  static String receptionist(PatientEntity e) => titled(e.receptionist);

  static String assistantManager(PatientEntity e) =>
      titled(e.assistantManager);

  static String historyTaker(PatientEntity e) => titled(e.historyTaker);

  static String consultant(PatientEntity e) => titled(e.consultant);

  static String therapist(PatientEntity e) => titled(e.therapist);

  static String createdDate(PatientEntity e) {
    final parsed = Helpers.tryParseDate(e.createdAt);
    if (parsed == null) return display(e.createdAt);
    return Helpers.formatDate(parsed, pattern: 'MM/dd/yy HH:mm');
  }
}
