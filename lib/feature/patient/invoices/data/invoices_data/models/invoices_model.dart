import '../../../domain/invoices_domain/entities/invoices_entity.dart';

// ============================================================
// INVOICES MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class InvoicesModel extends InvoicesEntity {
  const InvoicesModel({required super.id});

  factory InvoicesModel.fromJson(Map<String, dynamic> json) {
    return InvoicesModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  InvoicesEntity toEntity() => InvoicesEntity(id: id);
}
