import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT DUES HISTORY ENTITY (Domain)
// ------------------------------------------------------------
// One invoice row from GET /api/admin/reports/patient-dues/{id}
// ============================================================

class PatientDuesHistoryEntity extends Equatable {
  const PatientDuesHistoryEntity({
    required this.invoiceNumber,
    required this.date,
    required this.type,
    required this.billedAmount,
    required this.discount,
    required this.insurance,
    required this.paid,
    required this.due,
  });

  final String invoiceNumber;
  final String date;
  final String type;
  final double billedAmount;
  final double discount;
  final double insurance;
  final double paid;
  final double due;

  @override
  List<Object?> get props => [
        invoiceNumber,
        date,
        type,
        billedAmount,
        discount,
        insurance,
        paid,
        due,
      ];
}
