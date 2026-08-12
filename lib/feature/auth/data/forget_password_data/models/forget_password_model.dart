import '../../../domain/forget_password_domain/entities/forget_password_entity.dart';
import '../../login_data/models/login_json_helpers.dart';

// ============================================================
// FORGET PASSWORD MODEL (Data)
// ------------------------------------------------------------
// Parses API body, e.g.:
// {
//   "success": true,
//   "status_code": 200,
//   "message": "Reset link sent.",
//   "data": null
// }
// Null / empty message → "_" (then UI can show a default).
// ============================================================

class ForgetPasswordModel extends ForgetPasswordEntity {
  const ForgetPasswordModel({required super.message});

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    // API shape:
    // {
    //   "success": true,
    //   "status_code": 200,
    //   "message": "Thank you we will check if email exist..."
    // }
    return ForgetPasswordModel(
      message: LoginJsonHelpers.text(json['message']),
    );
  }

  Map<String, dynamic> toJson() => {'message': message};

  ForgetPasswordEntity toEntity() => ForgetPasswordEntity(message: message);
}
