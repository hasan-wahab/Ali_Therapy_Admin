import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_entity.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_overview_query.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/usecases/get_dashboard_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

// ============================================================
// HOME BLOC
// ------------------------------------------------------------
// First open  → HomeLoading (full-screen shimmer)
// Pull refresh → keep HomeLoaded, AppBar loading only
// UI → Event → UseCase → State → UI
// ============================================================

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.getDashboardUseCase}) : super(const HomeInitial()) {
    on<HomeDashboardRequested>(_onDashboardRequested);
    on<HomeDashboardRefreshed>(_onRefreshed);
  }

  final GetDashboardUseCase getDashboardUseCase;

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(HomeDashboardRefreshed(completer: completer));
    return completer.future;
  }

  Future<void> _onDashboardRequested(
    HomeDashboardRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    await _fetchOverview(emit, keepOnError: null);
  }

  Future<void> _onRefreshed(
    HomeDashboardRefreshed event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final current = state;
      if (current is HomeLoaded) {
        emit(current.copyWith(isRefreshingList: true));
        await _fetchOverview(emit, keepOnError: current.dashboard);
        return;
      }
      if (current is HomeError) {
        emit(
          HomeError(
            title: current.title,
            message: current.message,
            dashboard: current.dashboard,
            isRefreshingList: true,
          ),
        );
        await _fetchOverview(emit, keepOnError: current.dashboard);
        return;
      }
      await _fetchOverview(emit, keepOnError: null);
    } finally {
      if (!event.completer.isCompleted) {
        event.completer.complete();
      }
    }
  }

  Future<void> _fetchOverview(
    Emitter<HomeState> emit, {
    required DashboardEntity? keepOnError,
  }) async {
    final result = await getDashboardUseCase(
      const DashboardOverviewQuery(),
    );

    result.when(
      success: (dashboard) => emit(
        HomeLoaded(dashboard: dashboard),
      ),
      failure: (failure) {
        emit(
          HomeError(
            title: failure.title,
            message: failure.message,
            dashboard: keepOnError ?? DashboardEntity.empty(),
          ),
        );
        if (keepOnError != null) {
          emit(HomeLoaded(dashboard: keepOnError));
        }
      },
    );
  }
}
