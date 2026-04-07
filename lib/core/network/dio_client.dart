import 'package:dio/dio.dart';
import 'package:coredesk/core/constants/app_constants.dart';
import 'package:coredesk/core/exceptions/exceptions.dart';
import 'package:coredesk/core/network/mock_api_data.dart';

import '../apiServices/apiEndpoints.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        connectTimeout: AppConstants.apiTimeout,
        receiveTimeout: AppConstants.apiTimeout,
        headers: AppConstants.defaultHeaders,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      final options = Options();
      if (token != null) {
        options.headers?['Authorization'] = 'Bearer $token';
      }

      final mockData = _getMockData(path);
      if (mockData != null) {
        await Future.delayed(const Duration(milliseconds: 500));
        return mockData;
      }

      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );

      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      final options = Options();
      if (token != null) {
        options.headers?['Authorization'] = 'Bearer $token';
      }

      if (path == ApiEndpoints.login) {
        final loginData = data as Map<String, dynamic>;
        if (loginData['email'] == 'test@example.com' &&
            loginData['password'] == 'password123') {
          await Future.delayed(const Duration(milliseconds: 500));
          return mockLoginResponse;
        } else {
          throw ServerException(
            message: 'Invalid credentials',
            code: 'INVALID_CREDS',
          );
        }
      }

      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      final options = Options();
      if (token != null) {
        options.headers?['Authorization'] = 'Bearer $token';
      }

      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      final options = Options();
      if (token != null) {
        options.headers?['Authorization'] = 'Bearer $token';
      }

      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  dynamic _getMockData(String path) {
    if (path == ApiEndpoints.user) {
      return mockUserResponse;
    } else if (path == ApiEndpoints.stats) {
      return mockStatsResponse;
    } else if (path == ApiEndpoints.leaves) {
      return mockLeavesResponse;
    } else if (path == ApiEndpoints.holidays) {
      return mockHolidaysResponse;
    } else if (path.contains('attendance')) {
      return mockAttendanceResponse;
    }
    return null;
  }

  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  void _onError(DioException error, ErrorInterceptorHandler handler) {
    handler.next(error);
  }

  void _handleException(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        throw NetworkException(
          message: 'Connection timeout',
          code: 'TIMEOUT',
          originalError: error,
        );
      } else if (error.response?.statusCode == 401) {
        throw AuthException(
          message: 'Unauthorized',
          code: 'UNAUTHORIZED',
          originalError: error,
        );
      } else if (error.response?.statusCode == 403) {
        throw AuthException(
          message: 'Forbidden',
          code: 'FORBIDDEN',
          originalError: error,
        );
      } else if (error.response?.statusCode == 404) {
        throw ServerException(
          message: 'Not found',
          code: 'NOT_FOUND',
          originalError: error,
        );
      } else if (error.response?.statusCode == 500) {
        throw ServerException(
          message: 'Server error',
          code: 'SERVER_ERROR',
          originalError: error,
        );
      } else if (error.type == DioExceptionType.unknown) {
        throw NetworkException(
          message: 'No internet connection',
          code: 'NO_INTERNET',
          originalError: error,
        );
      } else {
        throw ServerException(
          message: error.message ?? 'Unknown error',
          code: 'UNKNOWN',
          originalError: error,
        );
      }
    } else if (error is AppException) {
      throw error;
    } else {
      throw ServerException(
        message: 'Unexpected error',
        code: 'UNEXPECTED',
        originalError: error,
      );
    }
  }
}
