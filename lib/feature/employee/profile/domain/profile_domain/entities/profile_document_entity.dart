import 'package:equatable/equatable.dart';

// ============================================================
// PROFILE DOCUMENT ENTITY (Domain)
// ------------------------------------------------------------
// One document row on the employee profile.
// ============================================================

class ProfileDocumentEntity extends Equatable {
  final String id;
  final String docTitle;
  final String docDescription;
  final String docFile;
  final String docExpiry;

  const ProfileDocumentEntity({
    required this.id,
    required this.docTitle,
    required this.docDescription,
    required this.docFile,
    required this.docExpiry,
  });

  @override
  List<Object?> get props => [
        id,
        docTitle,
        docDescription,
        docFile,
        docExpiry,
      ];
}
