import 'package:equatable/equatable.dart';

// ============================================================
// TOGGLE STATUS ENTITY (Domain)
// ------------------------------------------------------------
// Response from POST /employees/{id}/toggle-status
// ============================================================

class ToggleStatusEntity extends Equatable {
  final String id;
  final String name;
  final bool isActive;

  const ToggleStatusEntity({
    required this.id,
    required this.name,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, name, isActive];
}
