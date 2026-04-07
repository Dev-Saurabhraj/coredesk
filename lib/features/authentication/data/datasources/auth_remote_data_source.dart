import 'package:coredesk/core/network/dio_client.dart';
import 'package:coredesk/core/exceptions/exceptions.dart';
import 'package:coredesk/features/authentication/data/models/auth_model.dart';

import '../../../../core/apiServices/apiEndpoints.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<UserModel> getProfile(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl(this.dioClient);

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
      final response = await dioClient.post(
        ApiEndpoints.login,
        data: {'email': email.trim(), 'password': password},
      );
      if (response == null) {
        throw ServerException(
          message: 'Empty login response',
          code: 'EMPTY_RESPONSE',
        );
      }
      return AuthModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getProfile(String token) async {
    try {
      if (token.trim().isEmpty) {
        throw AuthException(
          message: 'Invalid token for profile',
          code: 'EMPTY_TOKEN',
        );
      }
      final response = await dioClient.get(ApiEndpoints.user, token: token);
      if (response == null) {
        throw ServerException(
          message: 'Empty profile response',
          code: 'EMPTY_RESPONSE',
        );
      }
      return UserModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
