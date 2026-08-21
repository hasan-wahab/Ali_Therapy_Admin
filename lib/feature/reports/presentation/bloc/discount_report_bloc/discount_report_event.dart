part of 'discount_report_bloc.dart';

abstract class DiscountReportEvent extends Equatable {
  const DiscountReportEvent();

  @override
  List<Object?> get props => [];
}

class DiscountReportStarted extends DiscountReportEvent {
  const DiscountReportStarted();
}

class DiscountReportRefreshed extends DiscountReportEvent {
  const DiscountReportRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

class DiscountReportLoadMore extends DiscountReportEvent {
  const DiscountReportLoadMore();
}

class DiscountReportSearchChanged extends DiscountReportEvent {
  const DiscountReportSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class DiscountReportSearchSubmitted extends DiscountReportEvent {
  const DiscountReportSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class DiscountReportFiltersApplied extends DiscountReportEvent {
  const DiscountReportFiltersApplied({
    this.clinicId,
    this.consultantId,
    this.receptionistId,
    this.fromDate,
    this.toDate,
    this.discountPercent,
    this.clearClinicId = false,
    this.clearConsultantId = false,
    this.clearReceptionistId = false,
    this.clearFromDate = false,
    this.clearToDate = false,
    this.clearDiscountPercent = false,
    this.resetAll = false,
  });

  final int? clinicId;
  final int? consultantId;
  final int? receptionistId;
  final String? fromDate;
  final String? toDate;
  final int? discountPercent;
  final bool clearClinicId;
  final bool clearConsultantId;
  final bool clearReceptionistId;
  final bool clearFromDate;
  final bool clearToDate;
  final bool clearDiscountPercent;
  final bool resetAll;

  @override
  List<Object?> get props => [
        clinicId,
        consultantId,
        receptionistId,
        fromDate,
        toDate,
        discountPercent,
        clearClinicId,
        clearConsultantId,
        clearReceptionistId,
        clearFromDate,
        clearToDate,
        clearDiscountPercent,
        resetAll,
      ];
}
