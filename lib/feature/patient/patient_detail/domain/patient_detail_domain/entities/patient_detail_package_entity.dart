import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT DETAIL PACKAGE (Domain)
// ------------------------------------------------------------
// API: data.packages[]
// ============================================================

class PatientDetailPackageEntity extends Equatable {
  const PatientDetailPackageEntity({
    this.id = '',
    this.packageName = '',
    this.completedSessions = 0,
    this.totalSessions = 0,
    this.price = 0,
    this.status = '',
  });

  final String id;
  final String packageName;
  final int completedSessions;
  final int totalSessions;
  final double price;
  final String status;

  @override
  List<Object?> get props => [
        id,
        packageName,
        completedSessions,
        totalSessions,
        price,
        status,
      ];
}
