import 'package:equatable/equatable.dart';

// ============================================================
// CREATE PATIENT ENTITY (Domain)
// ------------------------------------------------------------
// Response from POST /patients/create
// ============================================================

class CreatePatientEntity extends Equatable {
  const CreatePatientEntity({
    required this.message,
    this.username = '',
    this.password = '',
  });

  final String message;
  final String username;
  final String password;

  String get displayMessage {
    final base = message.trim().isEmpty
        ? 'Patient registered successfully!'
        : message.trim();
    final extras = <String>[];
    if (username.trim().isNotEmpty) extras.add('Username: ${username.trim()}');
    if (password.trim().isNotEmpty) extras.add('Password: ${password.trim()}');
    if (extras.isEmpty) return base;
    return '$base ${extras.join(' ')}';
  }

  @override
  List<Object?> get props => [message, username, password];
}
