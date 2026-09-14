import '../../../domain/all_patients_domain/entities/patient_entity.dart';
import 'patient_json_helpers.dart';

// ============================================================
// PATIENT MODEL (Data)
// ------------------------------------------------------------
// Parses one item from GET /api/admin/patients data.data[]
// ============================================================

class PatientModel extends PatientEntity {
  const PatientModel({
    required super.id,
    required super.name,
    required super.cnic,
    super.problems,
    super.insurance,
    super.totalBilled,
    super.paid,
    super.discount,
    super.insuranceAmount,
    super.remaining,
    super.remainingSessions,
    super.totalSessions,
    super.createdBy,
    super.receptionist,
    super.assistantManager,
    super.historyTaker,
    super.consultant,
    super.therapist,
    super.createdAt,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: PatientJsonHelpers.text(json['patient_id'] ?? json['id']),
      name: PatientJsonHelpers.text(json['name']),
      cnic: PatientJsonHelpers.text(json['cnic']),
      problems: PatientJsonHelpers.stringList(json['problems']),
      insurance: PatientJsonHelpers.text(json['insurance']),
      totalBilled: PatientJsonHelpers.decimal(json['total_billed']),
      paid: PatientJsonHelpers.decimal(json['paid']),
      discount: PatientJsonHelpers.decimal(json['discount']),
      insuranceAmount: PatientJsonHelpers.decimal(json['insurance_amount']),
      remaining: PatientJsonHelpers.decimal(json['remaining']),
      remainingSessions: PatientJsonHelpers.integer(json['remaining_sessions']),
      totalSessions: PatientJsonHelpers.integer(json['total_sessions']),
      createdBy: PatientJsonHelpers.text(json['created_by']),
      receptionist: PatientJsonHelpers.text(json['receptionist']),
      assistantManager: PatientJsonHelpers.text(json['assistant_manager']),
      historyTaker: PatientJsonHelpers.text(json['history_taker']),
      consultant: PatientJsonHelpers.text(json['consultant']),
      therapist: PatientJsonHelpers.text(json['therapist']),
      createdAt: PatientJsonHelpers.text(json['created_at']),
    );
  }

  static List<PatientModel> listFromJson(dynamic rawList) {
    final list = PatientJsonHelpers.listOrEmpty(rawList);
    final patients = <PatientModel>[];
    for (final item in list) {
      final map = PatientJsonHelpers.mapOrNull(item);
      if (map == null) continue;
      patients.add(PatientModel.fromJson(map));
    }
    return patients;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cnic': cnic,
      'problems': problems,
      'insurance': insurance,
      'total_billed': totalBilled,
      'paid': paid,
      'discount': discount,
      'insurance_amount': insuranceAmount,
      'remaining': remaining,
      'remaining_sessions': remainingSessions,
      'total_sessions': totalSessions,
      'created_by': createdBy,
      'receptionist': receptionist,
      'assistant_manager': assistantManager,
      'history_taker': historyTaker,
      'consultant': consultant,
      'therapist': therapist,
      'created_at': createdAt,
    };
  }

  PatientEntity toEntity() {
    return PatientEntity(
      id: id,
      name: name,
      cnic: cnic,
      problems: problems,
      insurance: insurance,
      totalBilled: totalBilled,
      paid: paid,
      discount: discount,
      insuranceAmount: insuranceAmount,
      remaining: remaining,
      remainingSessions: remainingSessions,
      totalSessions: totalSessions,
      createdBy: createdBy,
      receptionist: receptionist,
      assistantManager: assistantManager,
      historyTaker: historyTaker,
      consultant: consultant,
      therapist: therapist,
      createdAt: createdAt,
    );
  }
}
