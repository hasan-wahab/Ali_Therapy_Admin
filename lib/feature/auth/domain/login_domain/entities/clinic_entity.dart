import 'package:equatable/equatable.dart';

// ============================================================
// CLINIC ENTITY (Domain)
// ------------------------------------------------------------
// Nested clinic object from login "user.clinic".
// No Dio / JSON here — pure data for the app.
// ============================================================

class ClinicEntity extends Equatable {
  final String id;
  final String name;
  final String location;
  final String description;
  final String colourCode;
  final String createdBy;
  final String updatedBy;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;

  const ClinicEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.colourCode,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        location,
        description,
        colourCode,
        createdBy,
        updatedBy,
        deletedAt,
        createdAt,
        updatedAt,
      ];
}
