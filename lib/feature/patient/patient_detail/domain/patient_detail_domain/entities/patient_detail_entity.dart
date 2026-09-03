import 'package:equatable/equatable.dart';

import 'patient_detail_clinical_history_entity.dart';
import 'patient_detail_consultant_entity.dart';
import 'patient_detail_invoice_entity.dart';
import 'patient_detail_package_entity.dart';
import 'patient_detail_profile_entity.dart';
import 'patient_detail_progress_entity.dart';
import 'patient_detail_session_entity.dart';
import 'patient_detail_survey_entity.dart';
import 'patient_detail_visit_entity.dart';

// ============================================================
// PATIENT DETAIL ENTITY (Domain)
// ------------------------------------------------------------
// Full Patient View payload: data.profile + lists + reports.
// ============================================================

class PatientDetailEntity extends Equatable {
  const PatientDetailEntity({
    this.success = true,
    this.message = '',
    this.profile = const PatientDetailProfileEntity(),
    this.visits = const [],
    this.sessions = const [],
    this.invoices = const [],
    this.packages = const [],
    this.clinicalHistory = const PatientDetailClinicalHistoryEntity(),
    this.consultantDetails = const PatientDetailConsultantEntity(),
    this.progress = const [],
    this.surveys = const [],
  });

  final bool success;
  final String message;
  final PatientDetailProfileEntity profile;
  final List<PatientDetailVisitEntity> visits;
  final List<PatientDetailSessionEntity> sessions;
  final List<PatientDetailInvoiceEntity> invoices;
  final List<PatientDetailPackageEntity> packages;
  final PatientDetailClinicalHistoryEntity clinicalHistory;
  final PatientDetailConsultantEntity consultantDetails;
  final List<PatientDetailProgressVisitEntity> progress;
  final List<PatientDetailSurveyEntity> surveys;

  /// Same as profile.id (used by older stub callers).
  String get id => profile.id;

  @override
  List<Object?> get props => [
        success,
        message,
        profile,
        visits,
        sessions,
        invoices,
        packages,
        clinicalHistory,
        consultantDetails,
        progress,
        surveys,
      ];
}
