import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_entity.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/usecases/get_dashboard_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

// ============================================================
// HOME BLOC
// ============================================================

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetDashboardUseCase getDashboardUseCase;

  HomeBloc({required this.getDashboardUseCase}) : super(const HomeInitial()) {
    on<HomeDashboardRequested>(_onDashboardRequested);
    on<HomeDashboardRefreshed>(_onDashboardRequested);
  }

  Future<void> _onDashboardRequested(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    final result = await getDashboardUseCase(const NoParams());

    result.when(
      success: (dashboard) => emit(HomeLoaded(dashboard)),
      failure: (failure) => emit(HomeError(failure.message)),
    );
  }
}
