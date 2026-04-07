class AttendanceModel {
  final String id;
  final String date;
  final String checkIn;
  final String? checkOut;
  final String status;

  const AttendanceModel({
    required this.id,
    required this.date,
    required this.checkIn,
    this.checkOut,
    required this.status,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] as String? ?? '',
      date: json['date'] as String? ?? '',
      checkIn: json['checkIn'] as String? ?? json['check_in'] as String? ?? '',
      checkOut: json['checkOut'] as String? ?? json['check_out'] as String?,
      status: json['status'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'status': status,
    };
  }
}
