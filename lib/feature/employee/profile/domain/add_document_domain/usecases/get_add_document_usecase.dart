import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/add_document_entity.dart';
import '../repositories/add_document_repository.dart';

// ============================================================
// GET ADDDOCUMENT USE CASE
// ------------------------------------------------------------
// One job: fetch add document data.
// ============================================================

class GetAddDocumentUseCase extends UseCase<AddDocumentEntity, NoParams> {
  final AddDocumentRepository repository;

  GetAddDocumentUseCase(this.repository);

  @override
  ResultFuture<AddDocumentEntity> call(NoParams params) {
    return repository.getAddDocument();
  }
}
