
import 'package:coredesk/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:coredesk/features/authentication/data/models/auth_model.dart';
import 'package:coredesk/features/authentication/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coredesk/core/constants/app_constants.dart';
import 'package:coredesk/core/exceptions/exceptions.dart';

abstract class AuthRepository {
  Future<AuthModel> login(String email, String password);
  Future<UserModel> getProfile(String token);
  Future<void> logout();
  Future<bool> isLoggedIn();
  String? getStoredToken();
}



class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      if (email.trim().isEmpty) {
        throw ValidationException(
          message: 'Email cannot be empty',
          code: 'EMPTY_EMAIL',
        );
      }
      if (password.isEmpty) {
        throw ValidationException(
          message: 'Password cannot be empty',
          code: 'EMPTY_PASSWORD',
        );
      }

      final authModel = await remoteDataSource.login(email.trim(), password);

      if (authModel.token.isEmpty) {
        throw ServerException(
          message: 'Invalid authentication response',
          code: 'INVALID_RESPONSE',
        );
      }

      await sharedPreferences.setString(AppConstants.keyToken, authModel.token);
      await sharedPreferences.setString(AppConstants.keyUser, authModel.email);
      await sharedPreferences.setBool(AppConstants.keyIsLoggedIn, true);

      return authModel;
    } on AppException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: 'Login failed: ${e.toString()}',
        code: 'LOGIN_ERROR',
        originalError: e,
      );
    }
  }

  @override
  Future<UserModel> getProfile(String token) async {
    try {
      if (token.isEmpty) {
        throw AuthException(message: 'Token is empty', code: 'EMPTY_TOKEN');
      }
      return await remoteDataSource.getProfile(token);
    } on AppException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: 'Failed to fetch profile',
        code: 'PROFILE_ERROR',
        originalError: e,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await sharedPreferences.remove(AppConstants.keyToken);
      await sharedPreferences.remove(AppConstants.keyUser);
      await sharedPreferences.setBool(AppConstants.keyIsLoggedIn, false);
    } catch (e) {
      throw CacheException(
        message: 'Failed to logout',
        code: 'LOGOUT_ERROR',
        originalError: e,
      );
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final isLoggedIn =
          sharedPreferences.getBool(AppConstants.keyIsLoggedIn) ?? false;
      final token = getStoredToken();
      return isLoggedIn && token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  String? getStoredToken() {
    return sharedPreferences.getString(AppConstants.keyToken);
  }
}
