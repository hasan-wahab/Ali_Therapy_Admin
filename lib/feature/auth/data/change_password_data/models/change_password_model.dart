import '../../../domain/change_password_domain/entities/change_password_entity.dart';
import '../../login_data/models/login_json_helpers.dart';

// ============================================================
// CHANGE PASSWORD MODEL (Data)
// ------------------------------------------------------------
// Parses API body, e.g.:
// {
//   "success": true,
//   "status_code": 200,
//   "message": "Password changed successfully."
// }
// ============================================================

class ChangePasswordModel extends ChangePasswordEntity {
  const ChangePasswordModel({required super.message});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      message: LoginJsonHelpers.text(json['message']),
    );
  }

  Map<String, dynamic> toJson() => {'message': message};

  ChangePasswordEntity toEntity() => ChangePasswordEntity(message: message);

}
