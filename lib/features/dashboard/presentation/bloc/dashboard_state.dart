import 'package:equatable/equatable.dart';
import 'package:coredesk/features/leaves/data/models/leave_model.dart';
import 'package:coredesk/features/attendance/data/models/attendance_model.dart';

import '../../data/models/dashboard_stats_model.dart';
import '../../data/models/holiday_model.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardStatsLoading extends DashboardState {
  const DashboardStatsLoading();
}

class DashboardLeavesLoading extends DashboardState {
  const DashboardLeavesLoading();
}

class DashboardHolidaysLoading extends DashboardState {
  const DashboardHolidaysLoading();
}

class DashboardAttendanceLoading extends DashboardState {
  const DashboardAttendanceLoading();
}

class DashboardSuccess extends DashboardState {
  final DashboardStatsModel stats;
  final List<LeaveModel> leaves;
  final List<HolidayModel> holidays;
  final List<AttendanceModel> attendance;

  const DashboardSuccess({
    required this.stats,
    required this.leaves,
    required this.holidays,
    required this.attendance,
  });

  @override
  List<Object?> get props => [stats, leaves, holidays, attendance];
}

class DashboardStatsSuccess extends DashboardState {
  final DashboardStatsModel stats;

  const DashboardStatsSuccess(this.stats);

  @override
  List<Object?> get props => [stats];
}

class DashboardLeavesSuccess extends DashboardState {
  final List<LeaveModel> leaves;

  const DashboardLeavesSuccess(this.leaves);

  @override
  List<Object?> get props => [leaves];
}

class DashboardHolidaysSuccess extends DashboardState {
  final List<HolidayModel> holidays;

  const DashboardHolidaysSuccess(this.holidays);

  @override
  List<Object?> get props => [holidays];
}

class DashboardAttendanceSuccess extends DashboardState {
  final List<AttendanceModel> attendance;

  const DashboardAttendanceSuccess(this.attendance);

  @override
  List<Object?> get props => [attendance];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
