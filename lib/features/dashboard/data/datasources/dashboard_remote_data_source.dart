import 'package:coredesk/core/index.dart';
import 'package:coredesk/features/leaves/data/models/leave_model.dart';
import 'package:coredesk/features/attendance/data/models/attendance_model.dart';
import '../../../../core/apiServices/apiEndpoints.dart';
import '../models/holiday_model.dart';
import '../models/dashboard_stats_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardStatsModel> getStats(String token);
  Future<List<LeaveModel>> getLeaves(String token);
  Future<List<HolidayModel>> getHolidays(String token);
  Future<List<AttendanceModel>> getAttendance(String token);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final DioClient dioClient;

  DashboardRemoteDataSourceImpl(this.dioClient);

  @override
  Future<DashboardStatsModel> getStats(String token) async {
    try {
      if (token.trim().isEmpty) {
        throw AuthException(
          message: 'Invalid token for stats',
          code: 'EMPTY_TOKEN',
        );
      }
      final response = await dioClient.get(ApiEndpoints.stats, token: token);
      if (response == null) {
        throw ServerException(
          message: 'Empty stats response',
          code: 'EMPTY_RESPONSE',
        );
      }
      return DashboardStatsModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LeaveModel>> getLeaves(String token) async {
    try {
      if (token.trim().isEmpty) {
        throw AuthException(
          message: 'Invalid token for leaves',
          code: 'EMPTY_TOKEN',
        );
      }
      final response = await dioClient.get(ApiEndpoints.leaves, token: token);
      if (response == null) {
        return [];
      }
      final list = response as List;
      return list
          .map((e) => LeaveModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<HolidayModel>> getHolidays(String token) async {
    try {
      if (token.trim().isEmpty) {
        throw AuthException(
          message: 'Invalid token for holidays',
          code: 'EMPTY_TOKEN',
        );
      }
      final response = await dioClient.get(ApiEndpoints.holidays, token: token);
      if (response == null) {
        return [];
      }
      final list = response as List;
      return list
          .map((e) => HolidayModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AttendanceModel>> getAttendance(String token) async {
    try {
      if (token.trim().isEmpty) {
        throw AuthException(
          message: 'Invalid token for attendance',
          code: 'EMPTY_TOKEN',
        );
      }
      final response = await dioClient.get(
        '${ApiEndpoints.stats}/attendance',
        token: token,
      );
      if (response == null) {
        return [];
      }
      final list = response as List;
      return list
          .map((e) => AttendanceModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
