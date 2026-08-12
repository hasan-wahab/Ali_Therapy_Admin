import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/invoices_entity.dart';
import '../repositories/invoices_repository.dart';

// ============================================================
// GET INVOICES USE CASE
// ------------------------------------------------------------
// One job: fetch invoices data.
// ============================================================

class GetInvoicesUseCase extends UseCase<InvoicesEntity, NoParams> {
  final InvoicesRepository repository;

  GetInvoicesUseCase(this.repository);

  @override
  ResultFuture<InvoicesEntity> call(NoParams params) {
    return repository.getInvoices();
  }
}
