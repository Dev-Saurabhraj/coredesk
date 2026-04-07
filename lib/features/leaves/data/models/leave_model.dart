class LeaveModel {
  final String id;
  final String type;
  final String startDate;
  final String endDate;
  final String status;

  const LeaveModel({
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? '',
      startDate:
          json['startDate'] as String? ?? json['start_date'] as String? ?? '',
      endDate: json['endDate'] as String? ?? json['end_date'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
    };
  }
}
