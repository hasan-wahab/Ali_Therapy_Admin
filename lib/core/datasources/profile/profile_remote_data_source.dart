import 'package:ali_therapy_admin/feature/employee/profile/data/profile_data/models/profile_model.dart';

// ============================================================
// PROFILE REMOTE DATA SOURCE (contract)
// ------------------------------------------------------------
// GET employees/{id} — full profile for View screen.
// ============================================================

abstract class ProfileRemoteDataSource {
  /// Load one employee profile by id.
  Future<ProfileModel> getProfile({required String employeeId});
}
