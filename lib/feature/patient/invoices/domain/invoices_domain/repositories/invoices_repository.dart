import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/invoices_entity.dart';

// ============================================================
// INVOICES REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class InvoicesRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<InvoicesEntity> getInvoices();
}
