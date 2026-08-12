import '../../../domain/all_patients_domain/entities/all_patients_entity.dart';

// ============================================================
// ALLPATIENTS MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class AllPatientsModel extends AllPatientsEntity {
  const AllPatientsModel({required super.id});

  factory AllPatientsModel.fromJson(Map<String, dynamic> json) {
    return AllPatientsModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  AllPatientsEntity toEntity() => AllPatientsEntity(id: id);
}
