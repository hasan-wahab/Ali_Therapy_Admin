import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT REFERRAL TYPE ENTITY (Domain)
// ------------------------------------------------------------
// One item from form-data "referral_types".
// Extra flags tell the UI which follow-up field to show.
// ============================================================

class PatientReferralTypeEntity extends Equatable {
  const PatientReferralTypeEntity({
    required this.key,
    required this.label,
    this.needsField = false,
    this.needsPanel = false,
    this.needsSocial = false,
    this.needsText = false,
  });

  final String key;
  final String label;
  final bool needsField;
  final bool needsPanel;
  final bool needsSocial;
  final bool needsText;

  @override
  List<Object?> get props => [
        key,
        label,
        needsField,
        needsPanel,
        needsSocial,
        needsText,
      ];
}
