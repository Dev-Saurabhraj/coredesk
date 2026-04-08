import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class FetchDashboardDataEvent extends DashboardEvent {
  final String token;

  const FetchDashboardDataEvent(this.token);

  @override
  List<Object?> get props => [token];
}

class RefreshDashboardEvent extends DashboardEvent {
  final String token;

  const RefreshDashboardEvent(this.token);

  @override
  List<Object?> get props => [token];
}

class FetchStatsEvent extends DashboardEvent {
  final String token;

  const FetchStatsEvent(this.token);

  @override
  List<Object?> get props => [token];
}

class FetchLeavesEvent extends DashboardEvent {
  final String token;

  const FetchLeavesEvent(this.token);

  @override
  List<Object?> get props => [token];
}

class FetchHolidaysEvent extends DashboardEvent {
  final String token;

  const FetchHolidaysEvent(this.token);

  @override
  List<Object?> get props => [token];
}

class FetchAttendanceEvent extends DashboardEvent {
  final String token;

  const FetchAttendanceEvent(this.token);

  @override
  List<Object?> get props => [token];
}

class LoadMoreLeavesEvent extends DashboardEvent {
  final String token;

  const LoadMoreLeavesEvent(this.token);

  @override
  List<Object?> get props => [token];
}

class LoadMoreAttendanceEvent extends DashboardEvent {
  final String token;

  const LoadMoreAttendanceEvent(this.token);

  @override
  List<Object?> get props => [token];
}
