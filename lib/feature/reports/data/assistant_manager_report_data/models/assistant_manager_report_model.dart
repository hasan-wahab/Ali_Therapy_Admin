import '../../../domain/assistant_manager_report_domain/entities/assistant_manager_report_entity.dart';
import '../../../domain/assistant_manager_report_domain/entities/assistant_manager_report_page_entity.dart';
import '../../../domain/assistant_manager_report_domain/entities/assistant_manager_report_summary_entity.dart';

// ============================================================
// ASSISTANT MANAGER REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/assistant-manager
// ============================================================

class AssistantManagerReportModel extends AssistantManagerReportEntity {
  const AssistantManagerReportModel({
    required super.id,
    required super.visitDate,
    required super.patientName,
    required super.patientPhone,
    required super.patientCnic,
    required super.assistantManagerName,
    required super.consultantName,
    required super.clinicName,
    required super.stage,
  });

  factory AssistantManagerReportModel.fromJson(Map<String, dynamic> json) {
    return AssistantManagerReportModel(
      id: json['id']?.toString() ?? '',
      visitDate: json['visit_date']?.toString().trim() ?? '',
      patientName: json['patient_name']?.toString().trim() ?? '',
      patientPhone: json['patient_phone']?.toString().trim() ?? '',
      patientCnic: json['patient_cnic']?.toString().trim() ?? '',
      assistantManagerName:
          json['assistant_manager_name']?.toString().trim() ?? '',
      consultantName: json['consultant_name']?.toString().trim() ?? '',
      clinicName: json['clinic_name']?.toString().trim() ?? '',
      stage: json['stage']?.toString().trim() ?? '',
    );
  }

  static List<AssistantManagerReportModel> listFromJson(List<dynamic> list) =>
      list
          .whereType<Map>()
          .map((e) => AssistantManagerReportModel.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .toList();

  AssistantManagerReportEntity toEntity() => AssistantManagerReportEntity(
        id: id,
        visitDate: visitDate,
        patientName: patientName,
        patientPhone: patientPhone,
        patientCnic: patientCnic,
        assistantManagerName: assistantManagerName,
        consultantName: consultantName,
        clinicName: clinicName,
        stage: stage,
      );
}

// ============================================================
// ASSISTANT MANAGER REPORT PAGE MODEL
// ------------------------------------------------------------
// Wraps Laravel paginate response.
// ============================================================

class AssistantManagerReportPageModel extends AssistantManagerReportPageEntity {
  const AssistantManagerReportPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
    super.summary,
  });

  factory AssistantManagerReportPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? AssistantManagerReportModel.listFromJson(list)
        : <AssistantManagerReportModel>[];

    final total = (json['total'] as num?)?.toInt() ?? rows.length;

    return AssistantManagerReportPageModel(
      rows: rows,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: total,
      summary: AssistantManagerReportSummaryModel.fromJson(
        json,
        visitCount: total,
      ),
    );
  }

  AssistantManagerReportPageEntity toEntity() =>
      AssistantManagerReportPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
        summary: summary,
      );
}

class AssistantManagerReportSummaryModel
    extends AssistantManagerReportSummaryEntity {
  const AssistantManagerReportSummaryModel({
    required super.totalVisits,
    super.clinics,
  });

  factory AssistantManagerReportSummaryModel.fromJson(
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
      return const AssistantManagerReportSummaryModel(
        totalVisits: 0,
        clinics: [],
      );
    }

    return AssistantManagerReportSummaryModel(
      totalVisits: visits == 0 ? visitCount : visits,
      clinics: clinics,
    );
  }

  static List<AssistantManagerReportClinicVisitEntity> _clinicsFrom(
    Map<String, dynamic> json,
  ) {
    final raw = json['clinics'] ??
        json['clinic_visits'] ??
        json['by_clinic'] ??
        json['clinic_stats'];
    if (raw is List) {
      final result = <AssistantManagerReportClinicVisitEntity>[];
      for (final item in raw) {
        final map = _asMap(item);
        if (map == null) continue;
        final name = (map['clinic_name'] ?? map['name'] ?? map['clinic'])
            ?.toString()
            .trim();
        if (name == null || name.isEmpty) continue;
        result.add(
          AssistantManagerReportClinicVisitEntity(
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
        AssistantManagerReportClinicVisitEntity(
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
