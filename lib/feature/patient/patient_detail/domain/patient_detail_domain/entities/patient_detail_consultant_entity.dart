import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT DETAIL CONSULTANT (Domain)
// ------------------------------------------------------------
// API: data.consultant_details
// ============================================================

class PatientDetailConsultantMuscleEntity extends Equatable {
  const PatientDetailConsultantMuscleEntity({
    this.muscle = '',
    this.conditions = const [],
    this.manualTreatments = const [],
    this.otherTreatment = '',
    this.prescribedExercises = const [],
    this.defaultExercises = const [],
  });

  final String muscle;
  final List<String> conditions;
  final List<String> manualTreatments;
  final String otherTreatment;
  final List<String> prescribedExercises;
  final List<String> defaultExercises;

  @override
  List<Object?> get props => [
        muscle,
        conditions,
        manualTreatments,
        otherTreatment,
        prescribedExercises,
        defaultExercises,
      ];
}

class PatientDetailConsultantPrescriptionEntity extends Equatable {
  const PatientDetailConsultantPrescriptionEntity({
    this.electrotherapy = '',
    this.thermoCryotherapy = '',
    this.antiInflammatory = '',
    this.advancedTechniques = '',
    this.medications = '',
    this.topicals = '',
  });

  final String electrotherapy;
  final String thermoCryotherapy;
  final String antiInflammatory;
  final String advancedTechniques;
  final String medications;
  final String topicals;

  @override
  List<Object?> get props => [
        electrotherapy,
        thermoCryotherapy,
        antiInflammatory,
        advancedTechniques,
        medications,
        topicals,
      ];
}

class PatientDetailConsultantEntity extends Equatable {
  const PatientDetailConsultantEntity({
    this.id = '',
    this.visitId = '',
    this.createdAt = '',
    this.consultant = '',
    this.diagnosis = const [],
    this.note = '',
    this.prescribedSessionDuration = '',
    this.investigationsDone = const [],
    this.otherInvestigationsAdvice = '',
    this.specialTests = const {},
    this.mmt = const {},
    this.muscles = const [],
    this.prescription = const PatientDetailConsultantPrescriptionEntity(),
    this.assignedPackages = const [],
  });

  final String id;
  final String visitId;
  final String createdAt;
  final String consultant;
  final List<String> diagnosis;
  final String note;
  final String prescribedSessionDuration;
  final List<String> investigationsDone;
  final String otherInvestigationsAdvice;

  /// API sample is `[]`. Parsed as region → result when a map is sent.
  final Map<String, String> specialTests;
  final Map<String, String> mmt;
  final List<PatientDetailConsultantMuscleEntity> muscles;
  final PatientDetailConsultantPrescriptionEntity prescription;
  final List<String> assignedPackages;

  @override
  List<Object?> get props => [
        id,
        visitId,
        createdAt,
        consultant,
        diagnosis,
        note,
        prescribedSessionDuration,
        investigationsDone,
        otherInvestigationsAdvice,
        specialTests,
        mmt,
        muscles,
        prescription,
        assignedPackages,
      ];
}
