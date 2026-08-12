part of 'forget_password_bloc.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {
  const ForgetPasswordInitial();
}

class ForgetPasswordLoading extends ForgetPasswordState {
  const ForgetPasswordLoading();
}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final String message;

  const ForgetPasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ForgetPasswordError extends ForgetPasswordState {
  const ForgetPasswordError({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  List<Object?> get props => [title, message];
}
