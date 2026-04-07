import 'package:coredesk/features/authentication/data/models/auth_model.dart';
import 'package:coredesk/features/authentication/data/models/user_model.dart';
import 'package:coredesk/features/authentication/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthModel> call(String email, String password) {
    return repository.login(email, password);
  }
}

class GetProfileUseCase {
  final AuthRepository repository;

  GetProfileUseCase(this.repository);

  Future<UserModel> call(String token) {
    return repository.getProfile(token);
  }
}

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() {
    return repository.logout();
  }
}

class IsLoggedInUseCase {
  final AuthRepository repository;

  IsLoggedInUseCase(this.repository);

  Future<bool> call() {
    return repository.isLoggedIn();
  }
}
