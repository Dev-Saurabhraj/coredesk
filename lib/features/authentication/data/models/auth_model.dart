class AuthModel {
  final String token;
  final String userId;
  final String email;
  final String fullName;

  const AuthModel({
    required this.token,
    required this.userId,
    required this.email,
    required this.fullName,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] as String? ?? '',
      userId: json['userId'] as String? ?? json['user_id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fullName:
          json['fullName'] as String? ?? json['full_name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userId': userId,
      'email': email,
      'fullName': fullName,
    };
  }
}
