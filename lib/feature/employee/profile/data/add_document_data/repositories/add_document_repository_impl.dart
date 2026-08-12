import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/add_document_domain/entities/add_document_entity.dart';
import '../../../domain/add_document_domain/repositories/add_document_repository.dart';

// ============================================================
// ADDDOCUMENT REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class AddDocumentRepositoryImpl implements AddDocumentRepository {
  AddDocumentRepositoryImpl();

  @override
  ResultFuture<AddDocumentEntity> getAddDocument() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('AddDocument API not integrated yet.'),
    );
  }
}
