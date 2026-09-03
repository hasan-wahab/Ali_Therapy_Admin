import '../../../domain/patient_detail_domain/entities/patient_detail_clinical_history_entity.dart';
import '../../../domain/patient_detail_domain/entities/patient_detail_consultant_entity.dart';
import '../../../domain/patient_detail_domain/entities/patient_detail_entity.dart';
import '../../../domain/patient_detail_domain/entities/patient_detail_invoice_entity.dart';
import '../../../domain/patient_detail_domain/entities/patient_detail_package_entity.dart';
import '../../../domain/patient_detail_domain/entities/patient_detail_profile_entity.dart';
import '../../../domain/patient_detail_domain/entities/patient_detail_progress_entity.dart';
import '../../../domain/patient_detail_domain/entities/patient_detail_session_entity.dart';
import '../../../domain/patient_detail_domain/entities/patient_detail_survey_entity.dart';
import '../../../domain/patient_detail_domain/entities/patient_detail_visit_entity.dart';
import 'patient_detail_clinical_history_model.dart';
import 'patient_detail_consultant_model.dart';
import 'patient_detail_invoice_model.dart';
import 'patient_detail_json_helpers.dart';
import 'patient_detail_package_model.dart';
import 'patient_detail_profile_model.dart';
import 'patient_detail_progress_model.dart';
import 'patient_detail_session_model.dart';
import 'patient_detail_survey_model.dart';
import 'patient_detail_visit_model.dart';

// ============================================================
// PATIENT DETAIL MODEL (Data)
// ------------------------------------------------------------
// Parses Patient Full View:
// {
//   "success": true,
//   "data": {
//     "profile": { ... },
//     "visits": [ ... ],
//     "sessions": [ ... ],
//     "invoices": [ ... ],
//     "packages": [ ... ],
//     "clinical_history": { ... },
//     "consultant_details": { ... }
//   }
// }
//
// Pass either the full envelope OR just the "data" map.
// ============================================================

class PatientDetailModel extends PatientDetailEntity {
  const PatientDetailModel({
    super.success,
    super.message,
    super.profile,
    super.visits,
    super.sessions,
    super.invoices,
    super.packages,
    super.clinicalHistory,
    super.consultantDetails,
    super.progress,
    super.surveys,
  });

  /// Pass either the full response OR just the "data" map.
  factory PatientDetailModel.fromJson(Map<String, dynamic> json) {
    final data = PatientDetailJsonHelpers.mapOrNull(json['data']) ?? json;
    final profileJson = PatientDetailJsonHelpers.mapOrNull(data['profile']);
    // Prefer singular object; fall back to first item of the list.
    final historyJson =
        PatientDetailJsonHelpers.mapOrNull(data['clinical_history']) ??
            PatientDetailJsonHelpers.firstMap(data['clinical_histories']);
    final consultantJson =
        PatientDetailJsonHelpers.mapOrNull(data['consultant_details']) ??
            PatientDetailJsonHelpers.firstMap(data['consultant_assessments']);

    return PatientDetailModel(
      success: PatientDetailJsonHelpers.flag(json['success']),
      message: PatientDetailJsonHelpers.text(json['message']),
      profile: profileJson == null
          ? const PatientDetailProfileModel()
          : PatientDetailProfileModel.fromJson(profileJson),
      visits: PatientDetailVisitModel.listFromJson(data['visits']),
      sessions: PatientDetailSessionModel.listFromJson(data['sessions']),
      invoices: PatientDetailInvoiceModel.listFromJson(data['invoices']),
      packages: PatientDetailPackageModel.listFromJson(data['packages']),
      clinicalHistory: historyJson == null
          ? const PatientDetailClinicalHistoryModel()
          : PatientDetailClinicalHistoryModel.fromJson(historyJson),
      consultantDetails: consultantJson == null
          ? const PatientDetailConsultantModel()
          : PatientDetailConsultantModel.fromJson(consultantJson),
      progress: PatientDetailProgressVisitModel.listFromJson(
        data['patient_progress'] ?? data['progress'],
      ),
      surveys: PatientDetailSurveyModel.listFromJson(data['surveys']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'profile': profile is PatientDetailProfileModel
          ? (profile as PatientDetailProfileModel).toJson()
          : PatientDetailProfileModel(
              id: profile.id,
              name: profile.name,
              email: profile.email,
              phone: profile.phone,
              cnic: profile.cnic,
              dateOfBirth: profile.dateOfBirth,
              age: profile.age,
              gender: profile.gender,
              bloodGroup: profile.bloodGroup,
              insurance: profile.insurance,
              referredBy: profile.referredBy,
              lastVisitAt: profile.lastVisitAt,
              totalVisits: profile.totalVisits,
              activePackages: profile.activePackages,
              totalSpent: profile.totalSpent,
              therapySessions: profile.therapySessions,
            ).toJson(),
      'visits': visits
          .map(
            (item) => item is PatientDetailVisitModel
                ? item.toJson()
                : PatientDetailVisitModel(
                    id: item.id,
                    date: item.date,
                    type: item.type,
                    doctor: item.doctor,
                    stage: item.stage,
                    amount: item.amount,
                  ).toJson(),
          )
          .toList(),
      'sessions': sessions
          .map(
            (item) => item is PatientDetailSessionModel
                ? item.toJson()
                : PatientDetailSessionModel(
                    id: item.id,
                    sessionNumber: item.sessionNumber,
                    patientName: item.patientName,
                    cnic: item.cnic,
                    age: item.age,
                    gender: item.gender,
                    therapist: item.therapist,
                    packageName: item.packageName,
                    duration: item.duration,
                    startedAt: item.startedAt,
                    endedAt: item.endedAt,
                    modalities: item.modalities,
                    nextSession: item.nextSession,
                  ).toJson(),
          )
          .toList(),
      'invoices': invoices
          .map(
            (item) => item is PatientDetailInvoiceModel
                ? item.toJson()
                : PatientDetailInvoiceModel(
                    id: item.id,
                    type: item.type,
                    date: item.date,
                    amount: item.amount,
                    discount: item.discount,
                    paid: item.paid,
                    due: item.due,
                    status: item.status,
                    payments: item.payments,
                  ).toJson(),
          )
          .toList(),
      'packages': packages
          .map(
            (item) => item is PatientDetailPackageModel
                ? item.toJson()
                : PatientDetailPackageModel(
                    id: item.id,
                    packageName: item.packageName,
                    completedSessions: item.completedSessions,
                    totalSessions: item.totalSessions,
                    price: item.price,
                    status: item.status,
                  ).toJson(),
          )
          .toList(),
      'clinical_history': clinicalHistory is PatientDetailClinicalHistoryModel
          ? (clinicalHistory as PatientDetailClinicalHistoryModel).toJson()
          : const PatientDetailClinicalHistoryModel().toJson(),
      'consultant_details': consultantDetails is PatientDetailConsultantModel
          ? (consultantDetails as PatientDetailConsultantModel).toJson()
          : const PatientDetailConsultantModel().toJson(),
      'patient_progress': progress
          .map(
            (item) => item is PatientDetailProgressVisitModel
                ? item.toJson()
                : PatientDetailProgressVisitModel(
                    visitNumber: item.visitNumber,
                    visitId: item.visitId,
                    dateTime: item.dateTime,
                    visitType: item.visitType,
                    status: item.status,
                    events: item.events,
                  ).toJson(),
          )
          .toList(),
      'surveys': surveys
          .map(
            (item) => item is PatientDetailSurveyModel
                ? item.toJson()
                : PatientDetailSurveyModel(
                    visitId: item.visitId,
                    visitNumber: item.visitNumber,
                    visitTitle: item.visitTitle,
                    visitDate: item.visitDate,
                    therapist: item.therapist,
                    submittedAt: item.submittedAt,
                    questions: item.questions,
                  ).toJson(),
          )
          .toList(),
    };
  }

  PatientDetailEntity toEntity() {
    return PatientDetailEntity(
      success: success,
      message: message,
      profile: profile is PatientDetailProfileModel
          ? (profile as PatientDetailProfileModel).toEntity()
          : PatientDetailProfileEntity(
              id: profile.id,
              name: profile.name,
              email: profile.email,
              phone: profile.phone,
              cnic: profile.cnic,
              dateOfBirth: profile.dateOfBirth,
              age: profile.age,
              gender: profile.gender,
              bloodGroup: profile.bloodGroup,
              insurance: profile.insurance,
              referredBy: profile.referredBy,
              lastVisitAt: profile.lastVisitAt,
              totalVisits: profile.totalVisits,
              activePackages: profile.activePackages,
              totalSpent: profile.totalSpent,
              therapySessions: profile.therapySessions,
            ),
      visits: visits
          .map(
            (item) => item is PatientDetailVisitModel
                ? item.toEntity()
                : PatientDetailVisitEntity(
                    id: item.id,
                    date: item.date,
                    type: item.type,
                    doctor: item.doctor,
                    stage: item.stage,
                    amount: item.amount,
                  ),
          )
          .toList(),
      sessions: sessions
          .map(
            (item) => item is PatientDetailSessionModel
                ? item.toEntity()
                : PatientDetailSessionEntity(
                    id: item.id,
                    sessionNumber: item.sessionNumber,
                    patientName: item.patientName,
                    cnic: item.cnic,
                    age: item.age,
                    gender: item.gender,
                    therapist: item.therapist,
                    packageName: item.packageName,
                    duration: item.duration,
                    startedAt: item.startedAt,
                    endedAt: item.endedAt,
                    modalities: item.modalities,
                    nextSession: item.nextSession,
                  ),
          )
          .toList(),
      invoices: invoices
          .map(
            (item) => item is PatientDetailInvoiceModel
                ? item.toEntity()
                : PatientDetailInvoiceEntity(
                    id: item.id,
                    type: item.type,
                    date: item.date,
                    amount: item.amount,
                    discount: item.discount,
                    paid: item.paid,
                    due: item.due,
                    status: item.status,
                    payments: item.payments,
                  ),
          )
          .toList(),
      packages: packages
          .map(
            (item) => item is PatientDetailPackageModel
                ? item.toEntity()
                : PatientDetailPackageEntity(
                    id: item.id,
                    packageName: item.packageName,
                    completedSessions: item.completedSessions,
                    totalSessions: item.totalSessions,
                    price: item.price,
                    status: item.status,
                  ),
          )
          .toList(),
      clinicalHistory: clinicalHistory is PatientDetailClinicalHistoryModel
          ? (clinicalHistory as PatientDetailClinicalHistoryModel).toEntity()
          : PatientDetailClinicalHistoryEntity(
              id: clinicalHistory.id,
              visitId: clinicalHistory.visitId,
              patientName: clinicalHistory.patientName,
              age: clinicalHistory.age,
              occupation: clinicalHistory.occupation,
              createdAt: clinicalHistory.createdAt,
              painLocations: clinicalHistory.painLocations,
              region: clinicalHistory.region,
              chiefComplaint: clinicalHistory.chiefComplaint,
              painDetails: clinicalHistory.painDetails,
              radiatingPain: clinicalHistory.radiatingPain,
              associatedSymptoms: clinicalHistory.associatedSymptoms,
              movementRelatedPain: clinicalHistory.movementRelatedPain,
              onsetCause: clinicalHistory.onsetCause,
              aggravatingFactors: clinicalHistory.aggravatingFactors,
              relievingFactors: clinicalHistory.relievingFactors,
              functionalLimitations: clinicalHistory.functionalLimitations,
              gaitAnalysis: clinicalHistory.gaitAnalysis,
              pastHistory: clinicalHistory.pastHistory,
              investigations: clinicalHistory.investigations,
              redFlags: clinicalHistory.redFlags,
              faceOnset: clinicalHistory.faceOnset,
              faceEye: clinicalHistory.faceEye,
              speechEatingDrinking: clinicalHistory.speechEatingDrinking,
              facePain: clinicalHistory.facePain,
              householdWork: clinicalHistory.householdWork,
              womenOnly: clinicalHistory.womenOnly,
              menOnly: clinicalHistory.menOnly,
            ),
      consultantDetails: consultantDetails is PatientDetailConsultantModel
          ? (consultantDetails as PatientDetailConsultantModel).toEntity()
          : PatientDetailConsultantEntity(
              id: consultantDetails.id,
              visitId: consultantDetails.visitId,
              createdAt: consultantDetails.createdAt,
              consultant: consultantDetails.consultant,
              diagnosis: consultantDetails.diagnosis,
              note: consultantDetails.note,
              prescribedSessionDuration:
                  consultantDetails.prescribedSessionDuration,
              investigationsDone: consultantDetails.investigationsDone,
              otherInvestigationsAdvice:
                  consultantDetails.otherInvestigationsAdvice,
              specialTests: consultantDetails.specialTests,
              mmt: consultantDetails.mmt,
              muscles: consultantDetails.muscles,
              prescription: consultantDetails.prescription,
              assignedPackages: consultantDetails.assignedPackages,
            ),
      progress: progress
          .map(
            (item) => item is PatientDetailProgressVisitModel
                ? item.toEntity()
                : PatientDetailProgressVisitEntity(
                    visitNumber: item.visitNumber,
                    visitId: item.visitId,
                    dateTime: item.dateTime,
                    visitType: item.visitType,
                    status: item.status,
                    events: item.events,
                  ),
          )
          .toList(),
      surveys: surveys
          .map(
            (item) => item is PatientDetailSurveyModel
                ? item.toEntity()
                : PatientDetailSurveyEntity(
                    visitId: item.visitId,
                    visitNumber: item.visitNumber,
                    visitTitle: item.visitTitle,
                    visitDate: item.visitDate,
                    therapist: item.therapist,
                    submittedAt: item.submittedAt,
                    questions: item.questions,
                  ),
          )
          .toList(),
    );
  }
}
