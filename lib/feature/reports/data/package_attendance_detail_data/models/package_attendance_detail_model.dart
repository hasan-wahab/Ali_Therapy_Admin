import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/entities/package_attendance_detail_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/entities/package_attendance_detail_package_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/entities/package_attendance_session_entity.dart';

// ============================================================
// PACKAGE ATTENDANCE DETAIL MODEL (Data)
// ------------------------------------------------------------
// Parses GET /api/admin/reports/package-attendance/{patientId}
// Null / empty display strings become "_".
// ============================================================

class PackageAttendanceSessionModel extends PackageAttendanceSessionEntity {
  const PackageAttendanceSessionModel({
    required super.sessionNumber,
    required super.date,
    required super.therapistName,
    required super.clinicName,
    required super.timeDuration,
    required super.status,
    required super.notes,
  });

  factory PackageAttendanceSessionModel.fromJson(Map<String, dynamic> json) {
    return PackageAttendanceSessionModel(
      sessionNumber: _toInt(json['session_number']),
      date: _date(json['date']),
      therapistName: _text(json['therapist_name']),
      clinicName: _text(json['clinic_name']),
      timeDuration: _text(json['time_duration']),
      status: _text(json['status']),
      notes: _text(json['notes']),
    );
  }

  PackageAttendanceSessionEntity toEntity() => PackageAttendanceSessionEntity(
        sessionNumber: sessionNumber,
        date: date,
        therapistName: therapistName,
        clinicName: clinicName,
        timeDuration: timeDuration,
        status: status,
        notes: notes,
      );
}

class PackageAttendanceDetailPackageModel
    extends PackageAttendanceDetailPackageEntity {
  const PackageAttendanceDetailPackageModel({
    required super.id,
    required super.packageName,
    required super.purchasedDate,
    required super.sessionsTotal,
    required super.sessionsUsed,
    required super.status,
    required super.sessionsHistory,
  });

  factory PackageAttendanceDetailPackageModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawHistory = json['sessions_history'];
    final history = rawHistory is List
        ? rawHistory
            .whereType<Map>()
            .map(
              (e) => PackageAttendanceSessionModel.fromJson(
                Map<String, dynamic>.from(e),
              ),
            )
            .toList()
        : <PackageAttendanceSessionModel>[];

    return PackageAttendanceDetailPackageModel(
      id: json['id']?.toString() ?? '',
      packageName: _text(json['package_name']),
      purchasedDate: _date(json['purchased_date']),
      sessionsTotal: _toInt(json['sessions_total']),
      sessionsUsed: _toInt(json['sessions_used']),
      status: _text(json['status']),
      sessionsHistory: history,
    );
  }

  PackageAttendanceDetailPackageEntity toEntity() =>
      PackageAttendanceDetailPackageEntity(
        id: id,
        packageName: packageName,
        purchasedDate: purchasedDate,
        sessionsTotal: sessionsTotal,
        sessionsUsed: sessionsUsed,
        status: status,
        sessionsHistory: sessionsHistory,
      );
}

class PackageAttendanceDetailModel extends PackageAttendanceDetailEntity {
  const PackageAttendanceDetailModel({
    required super.id,
    required super.patientName,
    required super.mrNo,
    required super.patientPhone,
    required super.packages,
  });

  factory PackageAttendanceDetailModel.fromJson(Map<String, dynamic> json) {
    final rawPackages = json['packages'];
    final packages = rawPackages is List
        ? rawPackages
            .whereType<Map>()
            .map(
              (e) => PackageAttendanceDetailPackageModel.fromJson(
                Map<String, dynamic>.from(e),
              ),
            )
            .toList()
        : <PackageAttendanceDetailPackageModel>[];

    return PackageAttendanceDetailModel(
      id: json['id']?.toString() ?? '',
      patientName: _text(json['patient_name']),
      mrNo: _text(json['mr_no']),
      patientPhone: _text(json['patient_phone']),
      packages: packages,
    );
  }

  PackageAttendanceDetailEntity toEntity() => PackageAttendanceDetailEntity(
        id: id,
        patientName: patientName,
        mrNo: mrNo,
        patientPhone: patientPhone,
        packages: packages,
      );
}

String _text(dynamic value) {
  if (value == null) return '_';
  final text = value.toString().trim();
  return text.isEmpty ? '_' : text;
}

String _date(dynamic value) {
  final raw = _text(value);
  if (raw == '_') return raw;
  final parsed = Helpers.tryParseDate(raw);
  if (parsed == null) return raw;
  return Helpers.formatDate(parsed, pattern: 'dd MMM, yyyy');
}

int _toInt(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? 0;
}
