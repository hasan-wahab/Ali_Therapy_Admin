part of 'invoices_bloc.dart';

abstract class InvoicesEvent extends Equatable {
  const InvoicesEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class InvoicesStarted extends InvoicesEvent {
  const InvoicesStarted();
}
