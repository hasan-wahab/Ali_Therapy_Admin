import '../../../domain/patient_detail_domain/entities/patient_detail_consultant_entity.dart';
import 'patient_detail_json_helpers.dart';

// ============================================================
// PATIENT DETAIL CONSULTANT MODEL
// ------------------------------------------------------------
// Parses data.consultant_details
// ============================================================

class PatientDetailConsultantMuscleModel
    extends PatientDetailConsultantMuscleEntity {
  const PatientDetailConsultantMuscleModel({
    super.muscle,
    super.conditions,
    super.manualTreatments,
    super.otherTreatment,
    super.prescribedExercises,
    super.defaultExercises,
  });

  factory PatientDetailConsultantMuscleModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PatientDetailConsultantMuscleModel(
      muscle: PatientDetailJsonHelpers.text(json['muscle']),
      conditions: PatientDetailJsonHelpers.stringList(json['conditions']),
      manualTreatments:
          PatientDetailJsonHelpers.stringList(json['manual_treatments']),
      otherTreatment: PatientDetailJsonHelpers.text(json['other_treatment']),
      prescribedExercises:
          PatientDetailJsonHelpers.stringList(json['prescribed_exercises']),
      defaultExercises:
          PatientDetailJsonHelpers.stringList(json['default_exercises']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'muscle': muscle,
      'conditions': conditions,
      'manual_treatments': manualTreatments,
      'other_treatment': otherTreatment,
      'prescribed_exercises': prescribedExercises,
      'default_exercises': defaultExercises,
    };
  }

  PatientDetailConsultantMuscleEntity toEntity() {
    return PatientDetailConsultantMuscleEntity(
      muscle: muscle,
      conditions: conditions,
      manualTreatments: manualTreatments,
      otherTreatment: otherTreatment,
      prescribedExercises: prescribedExercises,
      defaultExercises: defaultExercises,
    );
  }
}

class PatientDetailConsultantPrescriptionModel
    extends PatientDetailConsultantPrescriptionEntity {
  const PatientDetailConsultantPrescriptionModel({
    super.electrotherapy,
    super.thermoCryotherapy,
    super.antiInflammatory,
    super.advancedTechniques,
    super.medications,
    super.topicals,
  });

  factory PatientDetailConsultantPrescriptionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PatientDetailConsultantPrescriptionModel(
      electrotherapy: PatientDetailJsonHelpers.text(json['electrotherapy']),
      thermoCryotherapy:
          PatientDetailJsonHelpers.text(json['thermo_cryotherapy']),
      antiInflammatory:
          PatientDetailJsonHelpers.text(json['anti_inflammatory']),
      advancedTechniques:
          PatientDetailJsonHelpers.text(json['advanced_techniques']),
      medications: PatientDetailJsonHelpers.text(json['medications']),
      topicals: PatientDetailJsonHelpers.text(json['topicals']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'electrotherapy': electrotherapy,
      'thermo_cryotherapy': thermoCryotherapy,
      'anti_inflammatory': antiInflammatory,
      'advanced_techniques': advancedTechniques,
      'medications': medications,
      'topicals': topicals,
    };
  }

  PatientDetailConsultantPrescriptionEntity toEntity() {
    return PatientDetailConsultantPrescriptionEntity(
      electrotherapy: electrotherapy,
      thermoCryotherapy: thermoCryotherapy,
      antiInflammatory: antiInflammatory,
      advancedTechniques: advancedTechniques,
      medications: medications,
      topicals: topicals,
    );
  }
}

class PatientDetailConsultantModel extends PatientDetailConsultantEntity {
  const PatientDetailConsultantModel({
    super.id,
    super.visitId,
    super.createdAt,
    super.consultant,
    super.diagnosis,
    super.note,
    super.prescribedSessionDuration,
    super.investigationsDone,
    super.otherInvestigationsAdvice,
    super.specialTests,
    super.mmt,
    super.muscles,
    super.prescription,
    super.assignedPackages,
  });

  factory PatientDetailConsultantModel.fromJson(Map<String, dynamic> json) {
    final prescriptionJson =
        PatientDetailJsonHelpers.mapOrNull(json['prescription']);

    return PatientDetailConsultantModel(
      id: PatientDetailJsonHelpers.text(json['id']),
      visitId: PatientDetailJsonHelpers.text(json['visit_id']),
      createdAt: PatientDetailJsonHelpers.text(json['created_at']),
      consultant: PatientDetailJsonHelpers.text(json['consultant']),
      diagnosis: PatientDetailJsonHelpers.stringList(json['diagnosis']),
      note: PatientDetailJsonHelpers.text(json['note']),
      prescribedSessionDuration:
          PatientDetailJsonHelpers.text(json['prescribed_session_duration']),
      investigationsDone:
          PatientDetailJsonHelpers.stringList(json['investigations_done']),
      otherInvestigationsAdvice:
          PatientDetailJsonHelpers.text(json['other_investigations_advice']),
      specialTests: PatientDetailJsonHelpers.stringMap(json['special_tests']),
      mmt: PatientDetailJsonHelpers.stringMap(json['mmt']),
      muscles: PatientDetailJsonHelpers.mapList(
        json['muscles'],
        PatientDetailConsultantMuscleModel.fromJson,
      ),
      prescription: prescriptionJson == null
          ? const PatientDetailConsultantPrescriptionModel()
          : PatientDetailConsultantPrescriptionModel.fromJson(prescriptionJson),
      assignedPackages:
          PatientDetailJsonHelpers.stringList(json['assigned_packages']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'visit_id': visitId,
      'created_at': createdAt,
      'consultant': consultant,
      'diagnosis': diagnosis,
      'note': note,
      'prescribed_session_duration': prescribedSessionDuration,
      'investigations_done': investigationsDone,
      'other_investigations_advice': otherInvestigationsAdvice,
      'special_tests': specialTests,
      'mmt': mmt,
      'muscles': muscles
          .map(
            (item) => item is PatientDetailConsultantMuscleModel
                ? item.toJson()
                : PatientDetailConsultantMuscleModel(
                    muscle: item.muscle,
                    conditions: item.conditions,
                    manualTreatments: item.manualTreatments,
                    otherTreatment: item.otherTreatment,
                    prescribedExercises: item.prescribedExercises,
                    defaultExercises: item.defaultExercises,
                  ).toJson(),
          )
          .toList(),
      'prescription': prescription is PatientDetailConsultantPrescriptionModel
          ? (prescription as PatientDetailConsultantPrescriptionModel).toJson()
          : PatientDetailConsultantPrescriptionModel(
              electrotherapy: prescription.electrotherapy,
              thermoCryotherapy: prescription.thermoCryotherapy,
              antiInflammatory: prescription.antiInflammatory,
              advancedTechniques: prescription.advancedTechniques,
              medications: prescription.medications,
              topicals: prescription.topicals,
            ).toJson(),
      'assigned_packages': assignedPackages,
    };
  }

  PatientDetailConsultantEntity toEntity() {
    return PatientDetailConsultantEntity(
      id: id,
      visitId: visitId,
      createdAt: createdAt,
      consultant: consultant,
      diagnosis: diagnosis,
      note: note,
      prescribedSessionDuration: prescribedSessionDuration,
      investigationsDone: investigationsDone,
      otherInvestigationsAdvice: otherInvestigationsAdvice,
      specialTests: specialTests,
      mmt: mmt,
      muscles: muscles
          .map(
            (item) => item is PatientDetailConsultantMuscleModel
                ? item.toEntity()
                : PatientDetailConsultantMuscleEntity(
                    muscle: item.muscle,
                    conditions: item.conditions,
                    manualTreatments: item.manualTreatments,
                    otherTreatment: item.otherTreatment,
                    prescribedExercises: item.prescribedExercises,
                    defaultExercises: item.defaultExercises,
                  ),
          )
          .toList(),
      prescription: prescription is PatientDetailConsultantPrescriptionModel
          ? (prescription as PatientDetailConsultantPrescriptionModel)
              .toEntity()
          : PatientDetailConsultantPrescriptionEntity(
              electrotherapy: prescription.electrotherapy,
              thermoCryotherapy: prescription.thermoCryotherapy,
              antiInflammatory: prescription.antiInflammatory,
              advancedTechniques: prescription.advancedTechniques,
              medications: prescription.medications,
              topicals: prescription.topicals,
            ),
      assignedPackages: assignedPackages,
    );
  }
}
