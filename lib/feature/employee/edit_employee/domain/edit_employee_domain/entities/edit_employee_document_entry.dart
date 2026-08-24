import 'package:equatable/equatable.dart';

// ============================================================
// EDIT EMPLOYEE DOCUMENT ENTRY (Domain)
// ============================================================

class EditEmployeeDocumentEntry extends Equatable {
  const EditEmployeeDocumentEntry({
    this.id = '',
    this.title = '',
    this.description = '',
    this.expiry = '',
  });

  final String id;
  final String title;
  final String description;
  final String expiry;

  bool get isEmpty =>
      title.trim().isEmpty &&
      description.trim().isEmpty &&
      expiry.trim().isEmpty;

  @override
  List<Object?> get props => [id, title, description, expiry];
}
