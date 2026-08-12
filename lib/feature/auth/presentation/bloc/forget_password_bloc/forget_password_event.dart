part of 'forget_password_bloc.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object?> get props => [];
}

/// User tapped "Send reset link" (or similar).
class ForgetPasswordSubmitted extends ForgetPasswordEvent {
  final String email;

  const ForgetPasswordSubmitted({required this.email});

  @override
  List<Object?> get props => [email];
}
