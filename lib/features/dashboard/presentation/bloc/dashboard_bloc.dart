import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coredesk/core/index.dart';
import 'package:coredesk/features/dashboard/domain/usecases/dashboard_use_cases.dart';
import '../../../attendance/data/models/attendance_model.dart';
import '../../../leaves/data/models/leave_model.dart';
import '../../../authentication/domain/usecases/auth_use_cases.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetStatsUseCase getStatsUseCase;
  final GetLeavesUseCase getLeavesUseCase;
  final GetHolidaysUseCase getHolidaysUseCase;
  final GetAttendanceUseCase getAttendanceUseCase;
  final GetProfileUseCase getProfileUseCase;

  DashboardBloc({
    required this.getStatsUseCase,
    required this.getLeavesUseCase,
    required this.getHolidaysUseCase,
    required this.getAttendanceUseCase,
    required this.getProfileUseCase,
  }) : super(const DashboardInitial()) {
    on<FetchDashboardDataEvent>(_onFetchDashboardData);
    on<RefreshDashboardEvent>(_onRefreshDashboard);
    on<FetchStatsEvent>(_onFetchStats);
    on<FetchLeavesEvent>(_onFetchLeaves);
    on<FetchHolidaysEvent>(_onFetchHolidays);
    on<FetchAttendanceEvent>(_onFetchAttendance);
    on<LoadMoreLeavesEvent>(_onLoadMoreLeaves);
    on<LoadMoreAttendanceEvent>(_onLoadMoreAttendance);
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
      final user = await getProfileUseCase(event.token);

      final uniqueLeaves = leaves.toSet().toList();
      final uniqueAttendance = attendance.toSet().toList();

      emit(
        DashboardSuccess(
          stats: stats,
          leaves: uniqueLeaves,
          holidays: holidays,
          attendance: uniqueAttendance,
          user: user,
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
      final user = await getProfileUseCase(event.token);

      final uniqueLeaves = leaves.toSet().toList();
      final uniqueAttendance = attendance.toSet().toList();

      emit(
        DashboardSuccess(
          stats: stats,
          leaves: uniqueLeaves,
          holidays: holidays,
          attendance: uniqueAttendance,
          user: user,
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

  Future<void> _onLoadMoreLeaves(
    LoadMoreLeavesEvent event,
    Emitter<DashboardState> emit,
  ) async {
    final currentState = state;
    if (currentState is DashboardSuccess) {
      if (currentState.hasReachedMaxLeaves ||
          currentState.isLoadingMoreLeaves) {
        return;
      }

      try {
        final nextPage = currentState.leavesPage + 1;
        emit(currentState.copyWith(isLoadingMoreLeaves: true));
        final newLeaves = await getLeavesUseCase(
          event.token,
          page: nextPage,
          limit: 10,
        );
        
        final allLeaves = <LeaveModel>[...currentState.leaves, ...newLeaves];
        final combinedLeaves = allLeaves.toSet().toList();

        emit(
          currentState.copyWith(
            leaves: combinedLeaves,
            isLoadingMoreLeaves: false,
            hasReachedMaxLeaves: newLeaves.isEmpty,
            leavesPage: newLeaves.isEmpty ? currentState.leavesPage : nextPage,
          ),
        );
      } catch (e) {
        print('Error in _onLoadMoreLeaves: \$e');
        emit(currentState.copyWith(isLoadingMoreLeaves: false));
        // Soft error handling without destroying the success state
      }
    }
  }

  Future<void> _onLoadMoreAttendance(
    LoadMoreAttendanceEvent event,
    Emitter<DashboardState> emit,
  ) async {
    final currentState = state;
    if (currentState is DashboardSuccess) {
      if (currentState.hasReachedMaxAttendance ||
          currentState.isLoadingMoreAttendance) {
        return;
      }

      try {
        final nextPage = currentState.attendancePage + 1;
        emit(currentState.copyWith(isLoadingMoreAttendance: true));
        final newAttendance = await getAttendanceUseCase(
          event.token,
          page: nextPage,
          limit: 10,
        );

        // Deduplicate attendance using Set (leverages hashCode and == operator)
        final allAttendance = <AttendanceModel>[
          ...currentState.attendance,
          ...newAttendance,
        ];
        final combinedAttendance = allAttendance.toSet().toList();

        emit(
          currentState.copyWith(
            attendance: combinedAttendance,
            isLoadingMoreAttendance: false,
            hasReachedMaxAttendance: newAttendance.isEmpty,
            attendancePage: newAttendance.isEmpty
                ? currentState.attendancePage
                : nextPage,
          ),
        );
      } catch (e) {
        emit(currentState.copyWith(isLoadingMoreAttendance: false));
      }
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
