import '../../../domain/receptionist_report_domain/entities/receptionist_report_entity.dart';
import '../../../domain/receptionist_report_domain/entities/receptionist_report_page_entity.dart';
import '../../../domain/receptionist_report_domain/entities/receptionist_report_summary_entity.dart';

// ============================================================
// RECEPTIONIST REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/receptionist
// ============================================================

class ReceptionistReportModel extends ReceptionistReportEntity {
  const ReceptionistReportModel({
    required super.id,
    required super.visitDate,
    required super.patientName,
    required super.patientPhone,
    required super.patientCnic,
    required super.receptionistName,
    required super.clinicName,
    required super.amountCollected,
  });

  factory ReceptionistReportModel.fromJson(Map<String, dynamic> json) {
    return ReceptionistReportModel(
      id: json['id']?.toString() ?? '',
      visitDate: json['visit_date']?.toString().trim() ?? '',
      patientName: json['patient_name']?.toString().trim() ?? '',
      patientPhone: json['patient_phone']?.toString().trim() ?? '',
      patientCnic: json['patient_cnic']?.toString().trim() ?? '',
      receptionistName: json['receptionist_name']?.toString().trim() ?? '',
      clinicName: json['clinic_name']?.toString().trim() ?? '',
      amountCollected: _toDouble(json['amount_collected']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  static List<ReceptionistReportModel> listFromJson(List<dynamic> list) =>
      list
          .whereType<Map>()
          .map((e) => ReceptionistReportModel.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .toList();

  ReceptionistReportEntity toEntity() => ReceptionistReportEntity(
        id: id,
        visitDate: visitDate,
        patientName: patientName,
        patientPhone: patientPhone,
        patientCnic: patientCnic,
        receptionistName: receptionistName,
        clinicName: clinicName,
        amountCollected: amountCollected,
      );
}

// ============================================================
// RECEPTIONIST REPORT PAGE MODEL
// ------------------------------------------------------------
// Wraps Laravel paginate response.
// ============================================================

class ReceptionistReportPageModel extends ReceptionistReportPageEntity {
  const ReceptionistReportPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
    super.summary,
  });

  factory ReceptionistReportPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? ReceptionistReportModel.listFromJson(list)
        : <ReceptionistReportModel>[];

    final total = (json['total'] as num?)?.toInt() ?? rows.length;

    return ReceptionistReportPageModel(
      rows: rows,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: total,
      summary: ReceptionistReportSummaryModel.fromJson(
        json,
        visitCount: total,
      ),
    );
  }

  ReceptionistReportPageEntity toEntity() => ReceptionistReportPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
        summary: summary,
      );
}

class ReceptionistReportSummaryModel extends ReceptionistReportSummaryEntity {
  const ReceptionistReportSummaryModel({
    required super.totalVisits,
    super.clinics,
  });

  factory ReceptionistReportSummaryModel.fromJson(
    Map<String, dynamic> json, {
    required int visitCount,
  }) {
    final totals = _asMap(json['totals']) ??
        _asMap(json['summary']) ??
        _asMap(json['stats']) ??
        json;

    final visits = _toInt(
      totals['total_visits'] ?? totals['visits'] ?? totals['visit_count'],
    );
    final clinics = _clinicsFrom(totals);

    if (visits == 0 && clinics.isEmpty) {
      return const ReceptionistReportSummaryModel(
        totalVisits: 0,
        clinics: [],
      );
    }

    return ReceptionistReportSummaryModel(
      totalVisits: visits == 0 ? visitCount : visits,
      clinics: clinics,
    );
  }

  static List<ReceptionistReportClinicVisitEntity> _clinicsFrom(
    Map<String, dynamic> json,
  ) {
    final raw = json['clinics'] ??
        json['clinic_visits'] ??
        json['by_clinic'] ??
        json['clinic_stats'];
    if (raw is List) {
      final result = <ReceptionistReportClinicVisitEntity>[];
      for (final item in raw) {
        final map = _asMap(item);
        if (map == null) continue;
        final name = (map['clinic_name'] ?? map['name'] ?? map['clinic'])
            ?.toString()
            .trim();
        if (name == null || name.isEmpty) continue;
        result.add(
          ReceptionistReportClinicVisitEntity(
            name: name,
            visits: _toInt(map['visits'] ?? map['count'] ?? map['total']),
          ),
        );
      }
      return result;
    }
    final map = _asMap(raw);
    if (map == null) return const [];
    return [
      for (final entry in map.entries)
        ReceptionistReportClinicVisitEntity(
          name: entry.key,
          visits: _toInt(entry.value),
        ),
    ];
  }

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }
}
