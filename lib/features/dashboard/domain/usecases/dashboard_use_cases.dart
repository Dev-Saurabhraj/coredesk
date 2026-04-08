import 'package:coredesk/features/leaves/data/models/leave_model.dart';
import 'package:coredesk/features/attendance/data/models/attendance_model.dart';
import 'package:coredesk/features/dashboard/domain/repositories/dashboard_repository.dart';

import '../../data/models/dashboard_stats_model.dart';
import '../../data/models/holiday_model.dart';

class GetStatsUseCase {
  final DashboardRepository repository;

  GetStatsUseCase(this.repository);

  Future<DashboardStatsModel> call(String token) {
    return repository.getStats(token);
  }
}

class GetLeavesUseCase {
  final DashboardRepository repository;

  GetLeavesUseCase(this.repository);

  Future<List<LeaveModel>> call(String token, {int page = 1, int limit = 10}) {
    return repository.getLeaves(token, page: page, limit: limit);
  }
}

class GetHolidaysUseCase {
  final DashboardRepository repository;

  GetHolidaysUseCase(this.repository);

  Future<List<HolidayModel>> call(String token) {
    return repository.getHolidays(token);
  }
}

class GetAttendanceUseCase {
  final DashboardRepository repository;

  GetAttendanceUseCase(this.repository);

  Future<List<AttendanceModel>> call(String token, {int page = 1, int limit = 10}) {
    return repository.getAttendance(token, page: page, limit: limit);
  }
}
