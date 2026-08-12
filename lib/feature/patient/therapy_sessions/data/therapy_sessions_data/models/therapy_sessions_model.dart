import '../../../domain/therapy_sessions_domain/entities/therapy_sessions_entity.dart';

// ============================================================
// THERAPYSESSIONS MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class TherapySessionsModel extends TherapySessionsEntity {
  const TherapySessionsModel({required super.id});

  factory TherapySessionsModel.fromJson(Map<String, dynamic> json) {
    return TherapySessionsModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  TherapySessionsEntity toEntity() => TherapySessionsEntity(id: id);
}
