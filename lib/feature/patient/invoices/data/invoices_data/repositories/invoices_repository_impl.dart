import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/invoices_domain/entities/invoices_entity.dart';
import '../../../domain/invoices_domain/repositories/invoices_repository.dart';

// ============================================================
// INVOICES REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class InvoicesRepositoryImpl implements InvoicesRepository {
  InvoicesRepositoryImpl();

  @override
  ResultFuture<InvoicesEntity> getInvoices() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('Invoices API not integrated yet.'),
    );
  }
}
