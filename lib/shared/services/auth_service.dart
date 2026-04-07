import 'package:coredesk/features/authentication/domain/repositories/auth_repository.dart';

class AuthService {
  final AuthRepository authRepository;

  AuthService({required this.authRepository});

  Future<bool> isLoggedIn() {
    return authRepository.isLoggedIn();
  }

  String? getToken() {
    return authRepository.getStoredToken();
  }

  Future<void> logout() {
    return authRepository.logout();
  }
}
