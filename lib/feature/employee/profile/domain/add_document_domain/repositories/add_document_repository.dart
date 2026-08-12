import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/add_document_entity.dart';

// ============================================================
// ADDDOCUMENT REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class AddDocumentRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<AddDocumentEntity> getAddDocument();
}
