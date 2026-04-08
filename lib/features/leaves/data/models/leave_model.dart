class LeaveModel {
  final String id;
  final String type;
  final String startDate;
  final String endDate;
  final String status;
  // Expanded fields to make the app look complete
  final String? duration;
  final String? reason;
  final String? appliedOn;
  final String? approvedBy;

  const LeaveModel({
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.duration,
    this.reason,
    this.appliedOn,
    this.approvedBy,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? '',
      startDate:
          json['startDate'] as String? ?? json['start_date'] as String? ?? '',
      endDate: json['endDate'] as String? ?? json['end_date'] as String? ?? '',
      status: json['status'] as String? ?? '',
      duration: json['duration'] as String?,
      reason: json['reason'] as String?,
      appliedOn: json['appliedOn'] as String? ?? json['applied_on'] as String?,
      approvedBy:
          json['approvedBy'] as String? ?? json['approved_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
      if (duration != null) 'duration': duration,
      if (reason != null) 'reason': reason,
      if (appliedOn != null) 'appliedOn': appliedOn,
      if (approvedBy != null) 'approvedBy': approvedBy,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaveModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
