final mockLoginResponse = {
  'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
  'userId': 'emp_12345',
  'email': 'test@example.com',
  'fullName': 'John Doe',
};

final mockUserResponse = {
  'id': 'emp_12345',
  'email': 'test@example.com',
  'fullName': 'John Doe',
  'role': 'Senior Developer',
  'avatar': 'https://api.example.com/avatars/john.jpg',
  'department': 'Engineering',
};

final mockStatsResponse = {'attendance': 22, 'leaves': 5, 'requests': 2};

final mockLeavesResponse = [
  {
    'id': 'leave_1',
    'type': 'Casual Leave',
    'startDate': '2024-04-10',
    'endDate': '2024-04-12',
    'status': 'Approved',
  },
  {
    'id': 'leave_2',
    'type': 'Sick Leave',
    'startDate': '2024-03-28',
    'endDate': '2024-03-29',
    'status': 'Approved',
  },
  {
    'id': 'leave_3',
    'type': 'Casual Leave',
    'startDate': '2024-04-20',
    'endDate': '2024-04-22',
    'status': 'Pending',
  },
];

final mockHolidaysResponse = [
  {'id': 'holiday_1', 'name': 'Good Friday', 'date': '2024-03-29'},
  {'id': 'holiday_2', 'name': 'Easter Monday', 'date': '2024-04-01'},
  {'id': 'holiday_3', 'name': 'Labour Day', 'date': '2024-05-01'},
  {'id': 'holiday_4', 'name': 'Bank Holiday', 'date': '2024-05-06'},
];

final mockAttendanceResponse = [
  {
    'id': 'att_1',
    'date': '2024-04-05',
    'checkIn': '09:15 AM',
    'checkOut': '06:30 PM',
    'status': 'Present',
  },
  {
    'id': 'att_2',
    'date': '2024-04-04',
    'checkIn': '09:00 AM',
    'checkOut': '06:15 PM',
    'status': 'Present',
  },
  {
    'id': 'att_3',
    'date': '2024-04-03',
    'checkIn': '10:30 AM',
    'checkOut': '05:45 PM',
    'status': 'Half Day',
  },
  {
    'id': 'att_4',
    'date': '2024-04-02',
    'checkIn': '09:10 AM',
    'checkOut': '06:20 PM',
    'status': 'Present',
  },
  {
    'id': 'att_5',
    'date': '2024-04-01',
    'checkIn': 'N/A',
    'checkOut': null,
    'status': 'Absent',
  },
];
