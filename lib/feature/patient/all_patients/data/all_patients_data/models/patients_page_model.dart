import '../../../domain/all_patients_domain/entities/patients_page_entity.dart';
import 'patient_json_helpers.dart';
import 'patient_model.dart';

// ============================================================
// PATIENTS PAGE MODEL (Data)
// ------------------------------------------------------------
// Parses Laravel paginate JSON:
//   { current_page, data: [...], last_page, per_page, total }
// ============================================================

class PatientsPageModel extends PatientsPageEntity {
  const PatientsPageModel({
    required super.patients,
    required super.currentPage,
    required super.lastPage,
    required super.perPage,
    required super.total,
  });

  factory PatientsPageModel.fromJson(Map<String, dynamic> json) {
    final patients = PatientModel.listFromJson(json['data']);

    return PatientsPageModel(
      patients: patients,
      currentPage: _intOf(json['current_page'], fallback: 1),
      lastPage: _intOf(json['last_page'], fallback: 1),
      perPage: _intOf(json['per_page'], fallback: patients.length),
      total: _intOf(json['total'], fallback: patients.length),
    );
  }

  factory PatientsPageModel.fromList(List<PatientModel> patients) {
    return PatientsPageModel(
      patients: patients,
      currentPage: 1,
      lastPage: 1,
      perPage: patients.length,
      total: patients.length,
    );
  }

  PatientsPageEntity toEntity() {
    return PatientsPageEntity(
      patients: patients
          .map((e) => e is PatientModel ? e.toEntity() : e)
          .toList(),
      currentPage: currentPage,
      lastPage: lastPage,
      perPage: perPage,
      total: total,
    );
  }

  static int _intOf(dynamic value, {required int fallback}) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(PatientJsonHelpers.text(value)) ?? fallback;
  }
}
