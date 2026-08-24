import '../../../domain/therapist_report_domain/entities/therapist_report_entity.dart';
import '../../../domain/therapist_report_domain/entities/therapist_report_page_entity.dart';
import '../../../domain/therapist_report_domain/entities/therapist_report_summary_entity.dart';

// ============================================================
// THERAPIST REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/therapist
// ============================================================

class TherapistReportModel extends TherapistReportEntity {
  const TherapistReportModel({
    required super.id,
    required super.visitDate,
    required super.patientName,
    required super.patientPhone,
    required super.patientCnic,
    required super.therapistName,
    required super.consultantName,
    required super.clinicName,
    required super.status,
  });

  factory TherapistReportModel.fromJson(Map<String, dynamic> json) {
    return TherapistReportModel(
      id: json['id']?.toString() ?? '',
      visitDate: json['visit_date']?.toString().trim() ?? '',
      patientName: json['patient_name']?.toString().trim() ?? '',
      patientPhone: json['patient_phone']?.toString().trim() ?? '',
      patientCnic: json['patient_cnic']?.toString().trim() ?? '',
      therapistName: json['therapist_name']?.toString().trim() ?? '',
      consultantName: json['consultant_name']?.toString().trim() ?? '',
      clinicName: json['clinic_name']?.toString().trim() ?? '',
      status: json['status']?.toString().trim() ?? '',
    );
  }

  static List<TherapistReportModel> listFromJson(List<dynamic> list) =>
      list
          .whereType<Map>()
          .map((e) => TherapistReportModel.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .toList();

  TherapistReportEntity toEntity() => TherapistReportEntity(
        id: id,
        visitDate: visitDate,
        patientName: patientName,
        patientPhone: patientPhone,
        patientCnic: patientCnic,
        therapistName: therapistName,
        consultantName: consultantName,
        clinicName: clinicName,
        status: status,
      );
}

// ============================================================
// THERAPIST REPORT PAGE MODEL
// ------------------------------------------------------------
// Wraps Laravel paginate response.
// ============================================================

class TherapistReportPageModel extends TherapistReportPageEntity {
  const TherapistReportPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
    super.summary,
  });

  factory TherapistReportPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? TherapistReportModel.listFromJson(list)
        : <TherapistReportModel>[];

    final total = (json['total'] as num?)?.toInt() ?? rows.length;

    return TherapistReportPageModel(
      rows: rows,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: total,
      summary: TherapistReportSummaryModel.fromJson(
        json,
        sessionCount: total,
      ),
    );
  }

  TherapistReportPageEntity toEntity() => TherapistReportPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
        summary: summary,
      );
}

class TherapistReportSummaryModel extends TherapistReportSummaryEntity {
  const TherapistReportSummaryModel({
    required super.totalSessions,
    super.clinics,
  });

  factory TherapistReportSummaryModel.fromJson(
    Map<String, dynamic> json, {
    required int sessionCount,
  }) {
    final totals = _asMap(json['totals']) ??
        _asMap(json['summary']) ??
        _asMap(json['stats']) ??
        json;

    final sessions = _toInt(
      totals['total_sessions'] ??
          totals['sessions'] ??
          totals['session_count'] ??
          totals['total_visits'],
    );
    final clinics = _clinicsFrom(totals);

    if (sessions == 0 && clinics.isEmpty) {
      return const TherapistReportSummaryModel(
        totalSessions: 0,
        clinics: [],
      );
    }

    return TherapistReportSummaryModel(
      totalSessions: sessions == 0 ? sessionCount : sessions,
      clinics: clinics,
    );
  }

  static List<TherapistReportClinicCountEntity> _clinicsFrom(
    Map<String, dynamic> json,
  ) {
    final raw = json['clinics'] ??
        json['clinic_visits'] ??
        json['by_clinic'] ??
        json['clinic_stats'];
    if (raw is List) {
      final result = <TherapistReportClinicCountEntity>[];
      for (final item in raw) {
        final map = _asMap(item);
        if (map == null) continue;
        final name = (map['clinic_name'] ?? map['name'] ?? map['clinic'])
            ?.toString()
            .trim();
        if (name == null || name.isEmpty) continue;
        result.add(
          TherapistReportClinicCountEntity(
            name: name,
            sessions: _toInt(
              map['sessions'] ??
                  map['visits'] ??
                  map['count'] ??
                  map['total'],
            ),
          ),
        );
      }
      return result;
    }
    final map = _asMap(raw);
    if (map == null) return const [];
    return [
      for (final entry in map.entries)
        TherapistReportClinicCountEntity(
          name: entry.key,
          sessions: _toInt(entry.value),
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
