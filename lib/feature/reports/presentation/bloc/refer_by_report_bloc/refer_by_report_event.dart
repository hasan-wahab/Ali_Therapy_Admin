part of 'refer_by_report_bloc.dart';

abstract class ReferByReportEvent extends Equatable {
  const ReferByReportEvent();

  @override
  List<Object?> get props => [];
}

class ReferByReportStarted extends ReferByReportEvent {
  const ReferByReportStarted();
}

class ReferByReportRefreshed extends ReferByReportEvent {
  const ReferByReportRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

class ReferByReportSearchChanged extends ReferByReportEvent {
  const ReferByReportSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class ReferByReportSearchSubmitted extends ReferByReportEvent {
  const ReferByReportSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class ReferByReportFiltersApplied extends ReferByReportEvent {
  const ReferByReportFiltersApplied({
    this.fromDate,
    this.toDate,
    this.clinicId,
    this.receptionistId,
    this.referralType,
    this.clearFromDate = false,
    this.clearToDate = false,
    this.clearClinicId = false,
    this.clearReceptionistId = false,
    this.clearReferralType = false,
    this.resetAll = false,
  });

  final String? fromDate;
  final String? toDate;
  final int? clinicId;
  final int? receptionistId;
  final String? referralType;

  final bool clearFromDate;
  final bool clearToDate;
  final bool clearClinicId;
  final bool clearReceptionistId;
  final bool clearReferralType;
  final bool resetAll;

  @override
  List<Object?> get props => [
        fromDate,
        toDate,
        clinicId,
        receptionistId,
        referralType,
        clearFromDate,
        clearToDate,
        clearClinicId,
        clearReceptionistId,
        clearReferralType,
        resetAll,
      ];
}
