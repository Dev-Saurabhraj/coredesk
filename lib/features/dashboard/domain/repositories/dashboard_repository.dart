import 'package:coredesk/features/leaves/data/models/leave_model.dart';
import 'package:coredesk/features/attendance/data/models/attendance_model.dart';
import '../../data/models/dashboard_stats_model.dart';
import '../../data/models/holiday_model.dart';

abstract class DashboardRepository {
  Future<DashboardStatsModel> getStats(String token);
  Future<List<LeaveModel>> getLeaves(String token, {int page = 1, int limit = 10});
  Future<List<HolidayModel>> getHolidays(String token);
  Future<List<AttendanceModel>> getAttendance(String token, {int page = 1, int limit = 10});
}
