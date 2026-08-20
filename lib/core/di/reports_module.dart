import 'package:ali_therapy_admin/core/datasources/reports/reports_remote_data_source.dart';
import 'package:ali_therapy_admin/core/datasources/reports/reports_remote_data_source_impl.dart';
import 'package:ali_therapy_admin/core/di/di_module.dart';
import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/feature/reports/data/assistant_manager_report_data/repositories/assistant_manager_report_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/consultation_report_data/repositories/consultation_report_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/free_consultation_report_data/repositories/free_consultation_report_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/insurance_panel_report_data/repositories/insurance_panel_report_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/package_attendance_data/repositories/package_attendance_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/package_attendance_detail_data/repositories/package_attendance_detail_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/patient_dues_data/repositories/patient_dues_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/patient_dues_history_data/repositories/patient_dues_history_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/patient_report_data/repositories/patient_report_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/reconsultation_report_data/repositories/reconsultation_report_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/refer_by_report_data/repositories/refer_by_report_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/report_filter_options_data/repositories/report_filter_options_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/receptionist_report_data/repositories/receptionist_report_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/therapist_report_data/repositories/therapist_report_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/data/user_activity_report_data/repositories/user_activity_report_repository_impl.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/repositories/assistant_manager_report_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/usecases/get_assistant_manager_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/consultation_report_domain/repositories/consultation_report_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/consultation_report_domain/usecases/get_consultation_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/free_consultation_report_domain/repositories/free_consultation_report_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/free_consultation_report_domain/usecases/get_free_consultation_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/repositories/insurance_panel_report_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/usecases/get_insurance_panel_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/repositories/package_attendance_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/usecases/get_package_attendance_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/repositories/package_attendance_detail_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_detail_domain/usecases/get_package_attendance_detail_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/repositories/patient_dues_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/usecases/get_patient_dues_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_history_domain/repositories/patient_dues_history_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_history_domain/usecases/get_patient_dues_history_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/repositories/patient_report_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/usecases/get_patient_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/repositories/reconsultation_report_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/usecases/get_reconsultation_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/repositories/refer_by_report_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/usecases/get_refer_by_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/repositories/report_filter_options_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/usecases/get_report_filter_options_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/repositories/receptionist_report_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/usecases/get_receptionist_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/repositories/therapist_report_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/usecases/get_therapist_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/repositories/user_activity_report_repository.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/usecases/get_user_activity_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/assistant_manager_report_bloc/assistant_manager_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/consultation_report_bloc/consultation_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/free_consultation_report_bloc/free_consultation_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/insurance_panel_report_bloc/insurance_panel_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/package_attendance_bloc/package_attendance_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/package_attendance_detail_bloc/package_attendance_detail_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/patient_dues_bloc/patient_dues_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/patient_dues_history_bloc/patient_dues_history_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/patient_report_bloc/patient_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/reconsultation_report_bloc/reconsultation_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/refer_by_report_bloc/refer_by_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/report_filter_options_bloc/report_filter_options_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/receptionist_report_bloc/receptionist_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/therapist_report_bloc/therapist_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/user_activity_report_bloc/user_activity_report_bloc.dart';
// ============================================================
// REPORTS MODULE (DI)
// ------------------------------------------------------------
// Order: data source → repository → use case → bloc
// ============================================================

class ReportsModule implements DiModule {
  @override
  Future<void> register() async {
    // Data source
    sl.registerLazySingleton<ReportsRemoteDataSource>(
      () => ReportsRemoteDataSourceImpl(dioClient: sl<DioClient>()),
    );

    // Repository
    sl.registerLazySingleton<ReportFilterOptionsRepository>(
      () => ReportFilterOptionsRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    // Use case
    sl.registerLazySingleton(
      () => GetReportFilterOptionsUseCase(
        sl<ReportFilterOptionsRepository>(),
      ),
    );

    // Bloc — singleton so filters are fetched once per session
    sl.registerLazySingleton(
      () => ReportFilterOptionsBloc(
        getFilterOptionsUseCase: sl<GetReportFilterOptionsUseCase>(),
      ),
    );

    // ── Patient Dues ─────────────────────────────────────────
    sl.registerLazySingleton<PatientDuesRepository>(
      () => PatientDuesRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetPatientDuesUseCase(sl<PatientDuesRepository>()),
    );

    // Factory — new Bloc instance per page visit (holds pagination state)
    sl.registerFactory(
      () => PatientDuesBloc(
        getPatientDuesUseCase: sl<GetPatientDuesUseCase>(),
        getReportFilterOptionsUseCase: sl<GetReportFilterOptionsUseCase>(),
      ),
    );

    sl.registerLazySingleton<PatientDuesHistoryRepository>(
      () => PatientDuesHistoryRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetPatientDuesHistoryUseCase(sl<PatientDuesHistoryRepository>()),
    );

    sl.registerFactory(
      () => PatientDuesHistoryBloc(
        getPatientDuesHistoryUseCase: sl<GetPatientDuesHistoryUseCase>(),
      ),
    );

    // ── Consultation Report ──────────────────────────────────
    sl.registerLazySingleton<ConsultationReportRepository>(
      () => ConsultationReportRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetConsultationReportUseCase(sl<ConsultationReportRepository>()),
    );

    sl.registerFactory(
      () => ConsultationReportBloc(
        getConsultationReportUseCase: sl<GetConsultationReportUseCase>(),
        getReportFilterOptionsUseCase: sl<GetReportFilterOptionsUseCase>(),
      ),
    );

    // ── Therapist Report ─────────────────────────────────────
    sl.registerLazySingleton<TherapistReportRepository>(
      () => TherapistReportRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetTherapistReportUseCase(sl<TherapistReportRepository>()),
    );

    sl.registerFactory(
      () => TherapistReportBloc(
        getTherapistReportUseCase: sl<GetTherapistReportUseCase>(),
        getReportFilterOptionsUseCase: sl<GetReportFilterOptionsUseCase>(),
      ),
    );

    // ── Reconsultation Report ────────────────────────────────
    sl.registerLazySingleton<ReconsultationReportRepository>(
      () => ReconsultationReportRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetReconsultationReportUseCase(
        sl<ReconsultationReportRepository>(),
      ),
    );

    sl.registerFactory(
      () => ReconsultationReportBloc(
        getReconsultationReportUseCase: sl<GetReconsultationReportUseCase>(),
        getReportFilterOptionsUseCase: sl<GetReportFilterOptionsUseCase>(),
      ),
    );

    // ── Free Consultation Report ─────────────────────────────
    sl.registerLazySingleton<FreeConsultationReportRepository>(
      () => FreeConsultationReportRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetFreeConsultationReportUseCase(
        sl<FreeConsultationReportRepository>(),
      ),
    );

    sl.registerFactory(
      () => FreeConsultationReportBloc(
        getFreeConsultationReportUseCase:
            sl<GetFreeConsultationReportUseCase>(),
        getReportFilterOptionsUseCase: sl<GetReportFilterOptionsUseCase>(),
      ),
    );

    // ── Assistant Manager Report ─────────────────────────────
    sl.registerLazySingleton<AssistantManagerReportRepository>(
      () => AssistantManagerReportRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetAssistantManagerReportUseCase(
        sl<AssistantManagerReportRepository>(),
      ),
    );

    sl.registerFactory(
      () => AssistantManagerReportBloc(
        getAssistantManagerReportUseCase:
            sl<GetAssistantManagerReportUseCase>(),
        getReportFilterOptionsUseCase: sl<GetReportFilterOptionsUseCase>(),
      ),
    );

    // ── Receptionist Report ──────────────────────────────────
    sl.registerLazySingleton<ReceptionistReportRepository>(
      () => ReceptionistReportRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetReceptionistReportUseCase(
        sl<ReceptionistReportRepository>(),
      ),
    );

    sl.registerFactory(
      () => ReceptionistReportBloc(
        getReceptionistReportUseCase: sl<GetReceptionistReportUseCase>(),
        getReportFilterOptionsUseCase: sl<GetReportFilterOptionsUseCase>(),
      ),
    );

    // ── Patient Report ───────────────────────────────────────
    sl.registerLazySingleton<PatientReportRepository>(
      () => PatientReportRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetPatientReportUseCase(sl<PatientReportRepository>()),
    );

    sl.registerFactory(
      () => PatientReportBloc(
        getPatientReportUseCase: sl<GetPatientReportUseCase>(),
        getReportFilterOptionsUseCase: sl<GetReportFilterOptionsUseCase>(),
      ),
    );

    // ── Package Attendance ───────────────────────────────────
    sl.registerLazySingleton<PackageAttendanceRepository>(
      () => PackageAttendanceRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetPackageAttendanceUseCase(sl<PackageAttendanceRepository>()),
    );

    sl.registerFactory(
      () => PackageAttendanceBloc(
        getPackageAttendanceUseCase: sl<GetPackageAttendanceUseCase>(),
        getReportFilterOptionsUseCase: sl<GetReportFilterOptionsUseCase>(),
      ),
    );

    sl.registerLazySingleton<PackageAttendanceDetailRepository>(
      () => PackageAttendanceDetailRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetPackageAttendanceDetailUseCase(
        sl<PackageAttendanceDetailRepository>(),
      ),
    );

    sl.registerFactory(
      () => PackageAttendanceDetailBloc(
        getPackageAttendanceDetailUseCase:
            sl<GetPackageAttendanceDetailUseCase>(),
      ),
    );

    // ── Refer By Report ──────────────────────────────────────
    sl.registerLazySingleton<ReferByReportRepository>(
      () => ReferByReportRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetReferByReportUseCase(sl<ReferByReportRepository>()),
    );

    sl.registerFactory(
      () => ReferByReportBloc(
        getReferByReportUseCase: sl<GetReferByReportUseCase>(),
        getReportFilterOptionsUseCase: sl<GetReportFilterOptionsUseCase>(),
      ),
    );

    // ── Insurance Panel Report ───────────────────────────────
    sl.registerLazySingleton<InsurancePanelReportRepository>(
      () => InsurancePanelReportRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetInsurancePanelReportUseCase(
        sl<InsurancePanelReportRepository>(),
      ),
    );

    sl.registerFactory(
      () => InsurancePanelReportBloc(
        getInsurancePanelReportUseCase: sl<GetInsurancePanelReportUseCase>(),
        getReportFilterOptionsUseCase: sl<GetReportFilterOptionsUseCase>(),
      ),
    );

    // ── User Activity Report ─────────────────────────────────
    sl.registerLazySingleton<UserActivityReportRepository>(
      () => UserActivityReportRepositoryImpl(
        remoteDataSource: sl<ReportsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetUserActivityReportUseCase(sl<UserActivityReportRepository>()),
    );

    sl.registerFactory(
      () => UserActivityReportBloc(
        getUserActivityReportUseCase: sl<GetUserActivityReportUseCase>(),
        getReportFilterOptionsUseCase: sl<GetReportFilterOptionsUseCase>(),
      ),
    );
  }
}
