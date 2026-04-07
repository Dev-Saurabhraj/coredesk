import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coredesk/core/exceptions/exceptions.dart';
import 'package:coredesk/features/dashboard/domain/usecases/dashboard_use_cases.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetStatsUseCase getStatsUseCase;
  final GetLeavesUseCase getLeavesUseCase;
  final GetHolidaysUseCase getHolidaysUseCase;
  final GetAttendanceUseCase getAttendanceUseCase;

  DashboardBloc({
    required this.getStatsUseCase,
    required this.getLeavesUseCase,
    required this.getHolidaysUseCase,
    required this.getAttendanceUseCase,
  }) : super(const DashboardInitial()) {
    on<FetchDashboardDataEvent>(_onFetchDashboardData);
    on<RefreshDashboardEvent>(_onRefreshDashboard);
    on<FetchStatsEvent>(_onFetchStats);
    on<FetchLeavesEvent>(_onFetchLeaves);
    on<FetchHolidaysEvent>(_onFetchHolidays);
    on<FetchAttendanceEvent>(_onFetchAttendance);
  }

  Future<void> _onFetchDashboardData(
    FetchDashboardDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLoading());
    try {
      final stats = await getStatsUseCase(event.token);
      final leaves = await getLeavesUseCase(event.token);
      final holidays = await getHolidaysUseCase(event.token);
      final attendance = await getAttendanceUseCase(event.token);

      emit(
        DashboardSuccess(
          stats: stats,
          leaves: leaves,
          holidays: holidays,
          attendance: attendance,
        ),
      );
    } catch (e) {
      emit(DashboardError(_getErrorMessage(e)));
    }
  }

  Future<void> _onRefreshDashboard(
    RefreshDashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final stats = await getStatsUseCase(event.token);
      final leaves = await getLeavesUseCase(event.token);
      final holidays = await getHolidaysUseCase(event.token);
      final attendance = await getAttendanceUseCase(event.token);

      emit(
        DashboardSuccess(
          stats: stats,
          leaves: leaves,
          holidays: holidays,
          attendance: attendance,
        ),
      );
    } catch (e) {
      emit(DashboardError(_getErrorMessage(e)));
    }
  }

  Future<void> _onFetchStats(
    FetchStatsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardStatsLoading());
    try {
      final stats = await getStatsUseCase(event.token);
      emit(DashboardStatsSuccess(stats));
    } catch (e) {
      emit(DashboardError(_getErrorMessage(e)));
    }
  }

  Future<void> _onFetchLeaves(
    FetchLeavesEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLeavesLoading());
    try {
      final leaves = await getLeavesUseCase(event.token);
      emit(DashboardLeavesSuccess(leaves));
    } catch (e) {
      emit(DashboardError(_getErrorMessage(e)));
    }
  }

  Future<void> _onFetchHolidays(
    FetchHolidaysEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardHolidaysLoading());
    try {
      final holidays = await getHolidaysUseCase(event.token);
      emit(DashboardHolidaysSuccess(holidays));
    } catch (e) {
      emit(DashboardError(_getErrorMessage(e)));
    }
  }

  Future<void> _onFetchAttendance(
    FetchAttendanceEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardAttendanceLoading());
    try {
      final attendance = await getAttendanceUseCase(event.token);
      emit(DashboardAttendanceSuccess(attendance));
    } catch (e) {
      emit(DashboardError(_getErrorMessage(e)));
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is ValidationException) {
      return 'Invalid input: ${error.message}';
    }
    if (error is AuthException) {
      return 'Authentication error: ${error.message}';
    }
    if (error is ServerException) {
      return 'Server error: ${error.message}';
    }
    if (error is NetworkException) {
      return 'Network error: ${error.message}';
    }
    if (error is AppException) {
      return error.message;
    }
    return 'An unexpected error occurred';
  }
}
