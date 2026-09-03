import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT DETAIL CLINICAL HISTORY (Domain)
// ------------------------------------------------------------
// API: data.clinical_history
// Face / household / women / men currently arrive as arrays.
// ============================================================

class PatientDetailComplaintGroupEntity extends Equatable {
  const PatientDetailComplaintGroupEntity({
    this.items = const [],
    this.sideAffected = const [],
    this.deviation = '',
  });

  /// `region.regions` or `chief_complaint.complaints`.
  final List<String> items;
  final List<String> sideAffected;
  final String deviation;

  @override
  List<Object?> get props => [items, sideAffected, deviation];
}

class PatientDetailPainDetailsEntity extends Equatable {
  const PatientDetailPainDetailsEntity({
    this.intensityVas = 0,
    this.typeOfPain = const [],
    this.painPattern = '',
    this.painTiming = const [],
    this.duration = '',
  });

  final int intensityVas;
  final List<String> typeOfPain;
  final String painPattern;
  final List<String> painTiming;
  final String duration;

  @override
  List<Object?> get props => [
        intensityVas,
        typeOfPain,
        painPattern,
        painTiming,
        duration,
      ];
}

class PatientDetailRadiatingPainEntity extends Equatable {
  const PatientDetailRadiatingPainEntity({
    this.status = '',
    this.radiationPath = const [],
    this.radiationSide = '',
  });

  final String status;
  final List<String> radiationPath;
  final String radiationSide;

  @override
  List<Object?> get props => [status, radiationPath, radiationSide];
}

class PatientDetailOnsetCauseEntity extends Equatable {
  const PatientDetailOnsetCauseEntity({
    this.howPainStarted = '',
    this.possibleCause = const [],
  });

  final String howPainStarted;
  final List<String> possibleCause;

  @override
  List<Object?> get props => [howPainStarted, possibleCause];
}

class PatientDetailPastHistoryEntity extends Equatable {
  const PatientDetailPastHistoryEntity({
    this.medicalHistory = const [],
    this.historyDetails = const [],
    this.surgicalHistory = '',
    this.previousTreatments = const [],
    this.physiotherapyResponse = '',
  });

  final List<String> medicalHistory;
  final List<String> historyDetails;
  final String surgicalHistory;
  final List<String> previousTreatments;
  final String physiotherapyResponse;

  @override
  List<Object?> get props => [
        medicalHistory,
        historyDetails,
        surgicalHistory,
        previousTreatments,
        physiotherapyResponse,
      ];
}

class PatientDetailClinicalHistoryEntity extends Equatable {
  const PatientDetailClinicalHistoryEntity({
    this.id = '',
    this.visitId = '',
    this.patientName = '',
    this.age = 0,
    this.occupation = '',
    this.createdAt = '',
    this.painLocations = const [],
    this.region = const PatientDetailComplaintGroupEntity(),
    this.chiefComplaint = const PatientDetailComplaintGroupEntity(),
    this.painDetails = const PatientDetailPainDetailsEntity(),
    this.radiatingPain = const PatientDetailRadiatingPainEntity(),
    this.associatedSymptoms = const [],
    this.movementRelatedPain = const [],
    this.onsetCause = const PatientDetailOnsetCauseEntity(),
    this.aggravatingFactors = const [],
    this.relievingFactors = const [],
    this.functionalLimitations = const [],
    this.gaitAnalysis = '',
    this.pastHistory = const PatientDetailPastHistoryEntity(),
    this.investigations = const [],
    this.redFlags = const [],
    this.faceOnset = const [],
    this.faceEye = const [],
    this.speechEatingDrinking = const [],
    this.facePain = const [],
    this.householdWork = const [],
    this.womenOnly = const [],
    this.menOnly = const [],
  });

  final String id;
  final String visitId;
  final String patientName;
  final int age;
  final String occupation;
  final String createdAt;
  final List<String> painLocations;
  final PatientDetailComplaintGroupEntity region;
  final PatientDetailComplaintGroupEntity chiefComplaint;
  final PatientDetailPainDetailsEntity painDetails;
  final PatientDetailRadiatingPainEntity radiatingPain;
  final List<String> associatedSymptoms;
  final List<String> movementRelatedPain;
  final PatientDetailOnsetCauseEntity onsetCause;
  final List<String> aggravatingFactors;
  final List<String> relievingFactors;
  final List<String> functionalLimitations;
  final String gaitAnalysis;
  final PatientDetailPastHistoryEntity pastHistory;
  final List<String> investigations;
  final List<String> redFlags;

  /// API currently sends empty arrays (not structured objects).
  final List<String> faceOnset;
  final List<String> faceEye;
  final List<String> speechEatingDrinking;
  final List<String> facePain;
  final List<String> householdWork;
  final List<String> womenOnly;
  final List<String> menOnly;

  @override
  List<Object?> get props => [
        id,
        visitId,
        patientName,
        age,
        occupation,
        createdAt,
        painLocations,
        region,
        chiefComplaint,
        painDetails,
        radiatingPain,
        associatedSymptoms,
        movementRelatedPain,
        onsetCause,
        aggravatingFactors,
        relievingFactors,
        functionalLimitations,
        gaitAnalysis,
        pastHistory,
        investigations,
        redFlags,
        faceOnset,
        faceEye,
        speechEatingDrinking,
        facePain,
        householdWork,
        womenOnly,
        menOnly,
      ];
}
