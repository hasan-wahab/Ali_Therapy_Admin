import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

// ============================================================
// GET PROFILE USE CASE
// ------------------------------------------------------------
// One job: fetch profile for the given employee id.
// ============================================================

class GetProfileParams {
  const GetProfileParams({required this.employeeId});

  final String employeeId;
}

class GetProfileUseCase extends UseCase<ProfileEntity, GetProfileParams> {
  GetProfileUseCase(this.repository);

  final ProfileRepository repository;

  @override
  ResultFuture<ProfileEntity> call(GetProfileParams params) {
    return repository.getProfile(employeeId: params.employeeId);
  }
}
