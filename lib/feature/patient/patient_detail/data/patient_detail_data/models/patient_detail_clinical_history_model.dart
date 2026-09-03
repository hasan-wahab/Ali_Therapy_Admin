import '../../../domain/patient_detail_domain/entities/patient_detail_clinical_history_entity.dart';
import 'patient_detail_json_helpers.dart';

// ============================================================
// PATIENT DETAIL CLINICAL HISTORY MODEL
// ------------------------------------------------------------
// Parses data.clinical_history
// ============================================================

class PatientDetailComplaintGroupModel
    extends PatientDetailComplaintGroupEntity {
  const PatientDetailComplaintGroupModel({
    super.items,
    super.sideAffected,
    super.deviation,
  });

  factory PatientDetailComplaintGroupModel.fromJson(
    Map<String, dynamic> json, {
    String itemsKey = 'regions',
  }) {
    return PatientDetailComplaintGroupModel(
      items: PatientDetailJsonHelpers.stringList(json[itemsKey]),
      sideAffected: PatientDetailJsonHelpers.stringList(json['side_affected']),
      deviation: PatientDetailJsonHelpers.text(json['deviation']),
    );
  }

  Map<String, dynamic> toJson({String itemsKey = 'regions'}) {
    return {
      itemsKey: items,
      'side_affected': sideAffected,
      'deviation': deviation,
    };
  }

  PatientDetailComplaintGroupEntity toEntity() {
    return PatientDetailComplaintGroupEntity(
      items: items,
      sideAffected: sideAffected,
      deviation: deviation,
    );
  }
}

class PatientDetailPainDetailsModel extends PatientDetailPainDetailsEntity {
  const PatientDetailPainDetailsModel({
    super.intensityVas,
    super.typeOfPain,
    super.painPattern,
    super.painTiming,
    super.duration,
  });

  factory PatientDetailPainDetailsModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailPainDetailsModel(
      intensityVas: PatientDetailJsonHelpers.integer(json['intensity_vas']),
      typeOfPain: PatientDetailJsonHelpers.stringList(json['type_of_pain']),
      painPattern: PatientDetailJsonHelpers.text(json['pain_pattern']),
      painTiming: PatientDetailJsonHelpers.stringList(json['pain_timing']),
      duration: PatientDetailJsonHelpers.text(json['duration']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'intensity_vas': intensityVas,
      'type_of_pain': typeOfPain,
      'pain_pattern': painPattern,
      'pain_timing': painTiming,
      'duration': duration,
    };
  }

  PatientDetailPainDetailsEntity toEntity() {
    return PatientDetailPainDetailsEntity(
      intensityVas: intensityVas,
      typeOfPain: typeOfPain,
      painPattern: painPattern,
      painTiming: painTiming,
      duration: duration,
    );
  }
}

class PatientDetailRadiatingPainModel
    extends PatientDetailRadiatingPainEntity {
  const PatientDetailRadiatingPainModel({
    super.status,
    super.radiationPath,
    super.radiationSide,
  });

  factory PatientDetailRadiatingPainModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailRadiatingPainModel(
      status: PatientDetailJsonHelpers.text(json['status']),
      radiationPath: PatientDetailJsonHelpers.stringList(json['radiation_path']),
      radiationSide: PatientDetailJsonHelpers.text(json['radiation_side']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'radiation_path': radiationPath,
      'radiation_side': radiationSide,
    };
  }

  PatientDetailRadiatingPainEntity toEntity() {
    return PatientDetailRadiatingPainEntity(
      status: status,
      radiationPath: radiationPath,
      radiationSide: radiationSide,
    );
  }
}

class PatientDetailOnsetCauseModel extends PatientDetailOnsetCauseEntity {
  const PatientDetailOnsetCauseModel({
    super.howPainStarted,
    super.possibleCause,
  });

  factory PatientDetailOnsetCauseModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailOnsetCauseModel(
      howPainStarted: PatientDetailJsonHelpers.text(json['how_pain_started']),
      possibleCause: PatientDetailJsonHelpers.stringList(json['possible_cause']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'how_pain_started': howPainStarted,
      'possible_cause': possibleCause,
    };
  }

  PatientDetailOnsetCauseEntity toEntity() {
    return PatientDetailOnsetCauseEntity(
      howPainStarted: howPainStarted,
      possibleCause: possibleCause,
    );
  }
}

class PatientDetailPastHistoryModel extends PatientDetailPastHistoryEntity {
  const PatientDetailPastHistoryModel({
    super.medicalHistory,
    super.historyDetails,
    super.surgicalHistory,
    super.previousTreatments,
    super.physiotherapyResponse,
  });

  factory PatientDetailPastHistoryModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailPastHistoryModel(
      medicalHistory:
          PatientDetailJsonHelpers.stringList(json['medical_history']),
      historyDetails:
          PatientDetailJsonHelpers.stringList(json['history_details']),
      surgicalHistory: PatientDetailJsonHelpers.text(json['surgical_history']),
      previousTreatments:
          PatientDetailJsonHelpers.stringList(json['previous_treatments']),
      physiotherapyResponse:
          PatientDetailJsonHelpers.text(json['physiotherapy_response']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medical_history': medicalHistory,
      'history_details': historyDetails,
      'surgical_history': surgicalHistory,
      'previous_treatments': previousTreatments,
      'physiotherapy_response': physiotherapyResponse,
    };
  }

  PatientDetailPastHistoryEntity toEntity() {
    return PatientDetailPastHistoryEntity(
      medicalHistory: medicalHistory,
      historyDetails: historyDetails,
      surgicalHistory: surgicalHistory,
      previousTreatments: previousTreatments,
      physiotherapyResponse: physiotherapyResponse,
    );
  }
}

class PatientDetailClinicalHistoryModel
    extends PatientDetailClinicalHistoryEntity {
  const PatientDetailClinicalHistoryModel({
    super.id,
    super.visitId,
    super.patientName,
    super.age,
    super.occupation,
    super.createdAt,
    super.painLocations,
    super.region,
    super.chiefComplaint,
    super.painDetails,
    super.radiatingPain,
    super.associatedSymptoms,
    super.movementRelatedPain,
    super.onsetCause,
    super.aggravatingFactors,
    super.relievingFactors,
    super.functionalLimitations,
    super.gaitAnalysis,
    super.pastHistory,
    super.investigations,
    super.redFlags,
    super.faceOnset,
    super.faceEye,
    super.speechEatingDrinking,
    super.facePain,
    super.householdWork,
    super.womenOnly,
    super.menOnly,
  });

  factory PatientDetailClinicalHistoryModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final regionJson = PatientDetailJsonHelpers.mapOrNull(json['region']);
    final complaintJson =
        PatientDetailJsonHelpers.mapOrNull(json['chief_complaint']);
    final painJson = PatientDetailJsonHelpers.mapOrNull(json['pain_details']);
    final radiatingJson =
        PatientDetailJsonHelpers.mapOrNull(json['radiating_pain']);
    final onsetJson = PatientDetailJsonHelpers.mapOrNull(json['onset_cause']);
    final pastJson = PatientDetailJsonHelpers.mapOrNull(json['past_history']);

    return PatientDetailClinicalHistoryModel(
      id: PatientDetailJsonHelpers.text(json['id']),
      visitId: PatientDetailJsonHelpers.text(json['visit_id']),
      patientName: PatientDetailJsonHelpers.text(json['patient_name']),
      age: PatientDetailJsonHelpers.integer(json['age']),
      occupation: PatientDetailJsonHelpers.text(json['occupation']),
      createdAt: PatientDetailJsonHelpers.text(json['created_at']),
      painLocations: PatientDetailJsonHelpers.stringList(json['pain_locations']),
      region: regionJson == null
          ? const PatientDetailComplaintGroupModel()
          : PatientDetailComplaintGroupModel.fromJson(
              regionJson,
              itemsKey: 'regions',
            ),
      chiefComplaint: complaintJson == null
          ? const PatientDetailComplaintGroupModel()
          : PatientDetailComplaintGroupModel.fromJson(
              complaintJson,
              itemsKey: 'complaints',
            ),
      painDetails: painJson == null
          ? const PatientDetailPainDetailsModel()
          : PatientDetailPainDetailsModel.fromJson(painJson),
      radiatingPain: radiatingJson == null
          ? const PatientDetailRadiatingPainModel()
          : PatientDetailRadiatingPainModel.fromJson(radiatingJson),
      associatedSymptoms:
          PatientDetailJsonHelpers.stringList(json['associated_symptoms']),
      movementRelatedPain:
          PatientDetailJsonHelpers.stringList(json['movement_related_pain']),
      onsetCause: onsetJson == null
          ? const PatientDetailOnsetCauseModel()
          : PatientDetailOnsetCauseModel.fromJson(onsetJson),
      aggravatingFactors:
          PatientDetailJsonHelpers.stringList(json['aggravating_factors']),
      relievingFactors:
          PatientDetailJsonHelpers.stringList(json['relieving_factors']),
      functionalLimitations:
          PatientDetailJsonHelpers.stringList(json['functional_limitations']),
      gaitAnalysis: PatientDetailJsonHelpers.text(json['gait_analysis']),
      pastHistory: pastJson == null
          ? const PatientDetailPastHistoryModel()
          : PatientDetailPastHistoryModel.fromJson(pastJson),
      investigations: PatientDetailJsonHelpers.stringList(json['investigations']),
      redFlags: PatientDetailJsonHelpers.stringList(json['red_flags']),
      faceOnset: PatientDetailJsonHelpers.stringList(json['face_onset']),
      faceEye: PatientDetailJsonHelpers.stringList(json['face_eye']),
      speechEatingDrinking:
          PatientDetailJsonHelpers.stringList(json['speech_eating_drinking']),
      facePain: PatientDetailJsonHelpers.stringList(json['face_pain']),
      householdWork: PatientDetailJsonHelpers.stringList(json['household_work']),
      womenOnly: PatientDetailJsonHelpers.stringList(json['women_only']),
      menOnly: PatientDetailJsonHelpers.stringList(json['men_only']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'visit_id': visitId,
      'patient_name': patientName,
      'age': age,
      'occupation': occupation,
      'created_at': createdAt,
      'pain_locations': painLocations,
      'region': region is PatientDetailComplaintGroupModel
          ? (region as PatientDetailComplaintGroupModel)
              .toJson(itemsKey: 'regions')
          : PatientDetailComplaintGroupModel(
              items: region.items,
              sideAffected: region.sideAffected,
              deviation: region.deviation,
            ).toJson(itemsKey: 'regions'),
      'chief_complaint': chiefComplaint is PatientDetailComplaintGroupModel
          ? (chiefComplaint as PatientDetailComplaintGroupModel)
              .toJson(itemsKey: 'complaints')
          : PatientDetailComplaintGroupModel(
              items: chiefComplaint.items,
              sideAffected: chiefComplaint.sideAffected,
              deviation: chiefComplaint.deviation,
            ).toJson(itemsKey: 'complaints'),
      'pain_details': painDetails is PatientDetailPainDetailsModel
          ? (painDetails as PatientDetailPainDetailsModel).toJson()
          : PatientDetailPainDetailsModel(
              intensityVas: painDetails.intensityVas,
              typeOfPain: painDetails.typeOfPain,
              painPattern: painDetails.painPattern,
              painTiming: painDetails.painTiming,
              duration: painDetails.duration,
            ).toJson(),
      'radiating_pain': radiatingPain is PatientDetailRadiatingPainModel
          ? (radiatingPain as PatientDetailRadiatingPainModel).toJson()
          : PatientDetailRadiatingPainModel(
              status: radiatingPain.status,
              radiationPath: radiatingPain.radiationPath,
              radiationSide: radiatingPain.radiationSide,
            ).toJson(),
      'associated_symptoms': associatedSymptoms,
      'movement_related_pain': movementRelatedPain,
      'onset_cause': onsetCause is PatientDetailOnsetCauseModel
          ? (onsetCause as PatientDetailOnsetCauseModel).toJson()
          : PatientDetailOnsetCauseModel(
              howPainStarted: onsetCause.howPainStarted,
              possibleCause: onsetCause.possibleCause,
            ).toJson(),
      'aggravating_factors': aggravatingFactors,
      'relieving_factors': relievingFactors,
      'functional_limitations': functionalLimitations,
      'gait_analysis': gaitAnalysis,
      'past_history': pastHistory is PatientDetailPastHistoryModel
          ? (pastHistory as PatientDetailPastHistoryModel).toJson()
          : PatientDetailPastHistoryModel(
              medicalHistory: pastHistory.medicalHistory,
              historyDetails: pastHistory.historyDetails,
              surgicalHistory: pastHistory.surgicalHistory,
              previousTreatments: pastHistory.previousTreatments,
              physiotherapyResponse: pastHistory.physiotherapyResponse,
            ).toJson(),
      'investigations': investigations,
      'red_flags': redFlags,
      'face_onset': faceOnset,
      'face_eye': faceEye,
      'speech_eating_drinking': speechEatingDrinking,
      'face_pain': facePain,
      'household_work': householdWork,
      'women_only': womenOnly,
      'men_only': menOnly,
    };
  }

  PatientDetailClinicalHistoryEntity toEntity() {
    return PatientDetailClinicalHistoryEntity(
      id: id,
      visitId: visitId,
      patientName: patientName,
      age: age,
      occupation: occupation,
      createdAt: createdAt,
      painLocations: painLocations,
      region: region is PatientDetailComplaintGroupModel
          ? (region as PatientDetailComplaintGroupModel).toEntity()
          : PatientDetailComplaintGroupEntity(
              items: region.items,
              sideAffected: region.sideAffected,
              deviation: region.deviation,
            ),
      chiefComplaint: chiefComplaint is PatientDetailComplaintGroupModel
          ? (chiefComplaint as PatientDetailComplaintGroupModel).toEntity()
          : PatientDetailComplaintGroupEntity(
              items: chiefComplaint.items,
              sideAffected: chiefComplaint.sideAffected,
              deviation: chiefComplaint.deviation,
            ),
      painDetails: painDetails is PatientDetailPainDetailsModel
          ? (painDetails as PatientDetailPainDetailsModel).toEntity()
          : PatientDetailPainDetailsEntity(
              intensityVas: painDetails.intensityVas,
              typeOfPain: painDetails.typeOfPain,
              painPattern: painDetails.painPattern,
              painTiming: painDetails.painTiming,
              duration: painDetails.duration,
            ),
      radiatingPain: radiatingPain is PatientDetailRadiatingPainModel
          ? (radiatingPain as PatientDetailRadiatingPainModel).toEntity()
          : PatientDetailRadiatingPainEntity(
              status: radiatingPain.status,
              radiationPath: radiatingPain.radiationPath,
              radiationSide: radiatingPain.radiationSide,
            ),
      associatedSymptoms: associatedSymptoms,
      movementRelatedPain: movementRelatedPain,
      onsetCause: onsetCause is PatientDetailOnsetCauseModel
          ? (onsetCause as PatientDetailOnsetCauseModel).toEntity()
          : PatientDetailOnsetCauseEntity(
              howPainStarted: onsetCause.howPainStarted,
              possibleCause: onsetCause.possibleCause,
            ),
      aggravatingFactors: aggravatingFactors,
      relievingFactors: relievingFactors,
      functionalLimitations: functionalLimitations,
      gaitAnalysis: gaitAnalysis,
      pastHistory: pastHistory is PatientDetailPastHistoryModel
          ? (pastHistory as PatientDetailPastHistoryModel).toEntity()
          : PatientDetailPastHistoryEntity(
              medicalHistory: pastHistory.medicalHistory,
              historyDetails: pastHistory.historyDetails,
              surgicalHistory: pastHistory.surgicalHistory,
              previousTreatments: pastHistory.previousTreatments,
              physiotherapyResponse: pastHistory.physiotherapyResponse,
            ),
      investigations: investigations,
      redFlags: redFlags,
      faceOnset: faceOnset,
      faceEye: faceEye,
      speechEatingDrinking: speechEatingDrinking,
      facePain: facePain,
      householdWork: householdWork,
      womenOnly: womenOnly,
      menOnly: menOnly,
    );
  }
}
