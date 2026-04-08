class AttendanceModel {
  final String id;
  final String date;
  final String checkIn;
  final String? checkOut;
  final String status;
  // Expanded fields
  final String? workHours;
  final String? location;
  final String? notes;

  const AttendanceModel({
    required this.id,
    required this.date,
    required this.checkIn,
    this.checkOut,
    required this.status,
    this.workHours,
    this.location,
    this.notes,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] as String? ?? '',
      date: json['date'] as String? ?? '',
      checkIn: json['checkIn'] as String? ?? json['check_in'] as String? ?? '',
      checkOut: json['checkOut'] as String? ?? json['check_out'] as String?,
      status: json['status'] as String? ?? '',
      workHours: json['workHours'] as String? ?? json['work_hours'] as String?,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'checkIn': checkIn,
      if (checkOut != null) 'checkOut': checkOut,
      'status': status,
      if (workHours != null) 'workHours': workHours,
      if (location != null) 'location': location,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
