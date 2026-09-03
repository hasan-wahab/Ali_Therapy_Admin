import 'package:ali_therapy_admin/core/datasources/patients/patients_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/utils/error_mapper.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../../../domain/all_patients_domain/entities/patients_list_query.dart';
import '../../../domain/all_patients_domain/entities/patients_page_entity.dart';
import '../../../domain/all_patients_domain/repositories/all_patients_repository.dart';

// ============================================================
// ALL PATIENTS REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Flow:
//   1. Check internet
//   2. Call remote data source (API page)
//   3. Map model → entity
// ============================================================

class AllPatientsRepositoryImpl implements AllPatientsRepository {
  AllPatientsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final PatientsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<PatientsPageEntity> getPatientsPage({
    required PatientsListQuery query,
  }) async {
    if (!await networkInfo.ensureConnected()) {
      const failure = NetworkFailure(
        'No internet connection. Please try again.',
      );
      AppErrorLogger.logFailure(
        failure,
        where: 'AllPatientsRepository.getPatientsPage',
      );
      return Result.failure(failure);
    }

    try {
      final model = await remoteDataSource.getPatientsPage(query: query);
      return Result.success(model.toEntity());
    } on AppException catch (e) {
      final failure = ErrorMapper.toFailure(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllPatientsRepository.getPatientsPage',
      );
      return Result.failure(failure);
    } catch (e) {
      final failure = ErrorMapper.fromUnknown(e);
      AppErrorLogger.logFailure(
        failure,
        where: 'AllPatientsRepository.getPatientsPage',
      );
      return Result.failure(failure);
    }
  }
}
