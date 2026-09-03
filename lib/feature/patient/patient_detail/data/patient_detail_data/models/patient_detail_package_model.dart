import '../../../domain/patient_detail_domain/entities/patient_detail_package_entity.dart';
import 'patient_detail_json_helpers.dart';

// ============================================================
// PATIENT DETAIL PACKAGE MODEL
// ------------------------------------------------------------
// Parses one item from data.packages
// ============================================================

class PatientDetailPackageModel extends PatientDetailPackageEntity {
  const PatientDetailPackageModel({
    super.id,
    super.packageName,
    super.completedSessions,
    super.totalSessions,
    super.price,
    super.status,
  });

  factory PatientDetailPackageModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailPackageModel(
      id: PatientDetailJsonHelpers.text(json['id']),
      packageName: PatientDetailJsonHelpers.text(json['package_name']),
      completedSessions:
          PatientDetailJsonHelpers.integer(json['completed_sessions']),
      totalSessions: PatientDetailJsonHelpers.integer(json['total_sessions']),
      price: PatientDetailJsonHelpers.decimal(json['price']),
      status: PatientDetailJsonHelpers.text(json['status']),
    );
  }

  static List<PatientDetailPackageModel> listFromJson(dynamic raw) {
    return PatientDetailJsonHelpers.mapList(
      raw,
      PatientDetailPackageModel.fromJson,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'package_name': packageName,
      'completed_sessions': completedSessions,
      'total_sessions': totalSessions,
      'price': price,
      'status': status,
    };
  }

  PatientDetailPackageEntity toEntity() {
    return PatientDetailPackageEntity(
      id: id,
      packageName: packageName,
      completedSessions: completedSessions,
      totalSessions: totalSessions,
      price: price,
      status: status,
    );
  }
}
