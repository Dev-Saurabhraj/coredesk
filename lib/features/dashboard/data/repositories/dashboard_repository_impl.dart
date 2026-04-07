import 'package:coredesk/features/dashboard/data/datasources/dashboard_remote_data_source.dart';

import 'package:coredesk/features/leaves/data/models/leave_model.dart';
import 'package:coredesk/features/attendance/data/models/attendance_model.dart';
import 'package:coredesk/features/dashboard/data/models/holiday_model.dart';
import 'package:coredesk/features/dashboard/data/models/dashboard_stats_model.dart';
import 'package:coredesk/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DashboardStatsModel> getStats(String token) {
    return remoteDataSource.getStats(token);
  }

  @override
  Future<List<LeaveModel>> getLeaves(String token) {
    return remoteDataSource.getLeaves(token);
  }

  @override
  Future<List<HolidayModel>> getHolidays(String token) {
    return remoteDataSource.getHolidays(token);
  }

  @override
  Future<List<AttendanceModel>> getAttendance(String token) {
    return remoteDataSource.getAttendance(token);
  }
}
