class DashboardStatsModel {
  final int attendance;
  final int leaves;
  final int requests;

  const DashboardStatsModel({
    required this.attendance,
    required this.leaves,
    required this.requests,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      attendance: json['attendance'] as int? ?? 0,
      leaves: json['leaves'] as int? ?? 0,
      requests: json['requests'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'attendance': attendance, 'leaves': leaves, 'requests': requests};
  }
}
