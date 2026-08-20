import '../../../domain/package_attendance_domain/entities/package_attendance_entity.dart';
import '../../../domain/package_attendance_domain/entities/package_attendance_package_entity.dart';
import '../../../domain/package_attendance_domain/entities/package_attendance_page_entity.dart';

// ============================================================
// PACKAGE ATTENDANCE PACKAGE MODEL (Data)
// ============================================================

class PackageAttendancePackageModel extends PackageAttendancePackageEntity {
  const PackageAttendancePackageModel({
    required super.id,
    required super.packageName,
    required super.sessionsTotal,
    required super.sessionsUsed,
    required super.status,
  });

  factory PackageAttendancePackageModel.fromJson(Map<String, dynamic> json) {
    return PackageAttendancePackageModel(
      id: json['id']?.toString() ?? '',
      packageName: json['package_name']?.toString().trim() ?? '',
      sessionsTotal: _toInt(json['sessions_total']),
      sessionsUsed: _toInt(json['sessions_used']),
      status: json['status']?.toString().trim() ?? '',
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  PackageAttendancePackageEntity toEntity() => PackageAttendancePackageEntity(
        id: id,
        packageName: packageName,
        sessionsTotal: sessionsTotal,
        sessionsUsed: sessionsUsed,
        status: status,
      );
}

// ============================================================
// PACKAGE ATTENDANCE MODEL (Data)
// ------------------------------------------------------------
// Parses one patient row from GET /reports/package-attendance
// ============================================================

class PackageAttendanceModel extends PackageAttendanceEntity {
  const PackageAttendanceModel({
    required super.id,
    required super.patientName,
    required super.mrNo,
    required super.gender,
    required super.patientPhone,
    required super.hasNfc,
    required super.patientCnic,
    required super.packages,
  });

  factory PackageAttendanceModel.fromJson(Map<String, dynamic> json) {
    final rawPackages = json['packages'];
    final packages = rawPackages is List
        ? rawPackages
            .whereType<Map>()
            .map(
              (e) => PackageAttendancePackageModel.fromJson(
                Map<String, dynamic>.from(e),
              ),
            )
            .toList()
        : <PackageAttendancePackageModel>[];

    return PackageAttendanceModel(
      id: json['id']?.toString() ?? '',
      patientName: json['patient_name']?.toString().trim() ?? '',
      mrNo: json['mr_no']?.toString().trim() ?? '',
      gender: json['gender']?.toString().trim() ?? '',
      patientPhone: json['patient_phone']?.toString().trim() ?? '',
      hasNfc: json['has_nfc'] == true,
      patientCnic: json['patient_cnic']?.toString().trim() ?? '',
      packages: packages,
    );
  }

  static List<PackageAttendanceModel> listFromJson(List<dynamic> list) => list
      .whereType<Map>()
      .map((e) => PackageAttendanceModel.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  PackageAttendanceEntity toEntity() => PackageAttendanceEntity(
        id: id,
        patientName: patientName,
        mrNo: mrNo,
        gender: gender,
        patientPhone: patientPhone,
        hasNfc: hasNfc,
        patientCnic: patientCnic,
        packages: packages,
      );
}

// ============================================================
// PACKAGE ATTENDANCE PAGE MODEL
// ------------------------------------------------------------
// Wraps Laravel paginate response.
// ============================================================

class PackageAttendancePageModel extends PackageAttendancePageEntity {
  const PackageAttendancePageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
  });

  factory PackageAttendancePageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? PackageAttendanceModel.listFromJson(list)
        : <PackageAttendanceModel>[];

    return PackageAttendancePageModel(
      rows: rows,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: (json['total'] as num?)?.toInt() ?? rows.length,
    );
  }

  PackageAttendancePageEntity toEntity() => PackageAttendancePageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
      );
}
