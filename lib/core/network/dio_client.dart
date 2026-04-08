import 'package:dio/dio.dart';
import 'package:coredesk/core/index.dart';
import 'package:coredesk/core/network/mock_api_data.dart';

import '../apiServices/apiEndpoints.dart';

class DioClient {
  late final Dio _dio;
  static const int _maxRetries = 3;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 15),
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
    bool retryOnError = true,
  }) async {
    return _executeWithRetry(
      () => _performGet(path, queryParameters, token),
      retryOnError: retryOnError,
      path: path,
    );
  }

  Future<dynamic> _performGet(
    String path,
    Map<String, dynamic>? queryParameters,
    String? token,
  ) async {
    final options = _createOptions(token);

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
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool retryOnError = true,
  }) async {
    return _executeWithRetry(
      () => _performPost(path, data, queryParameters, token),
      retryOnError: retryOnError,
      path: path,
    );
  }

  Future<dynamic> _performPost(
    String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  ) async {
    final options = _createOptions(token);

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
  }

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool retryOnError = true,
  }) async {
    return _executeWithRetry(
      () => _performPut(path, data, queryParameters, token),
      retryOnError: retryOnError,
      path: path,
    );
  }

  Future<dynamic> _performPut(
    String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  ) async {
    final options = _createOptions(token);

    final response = await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return response.data;
  }

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool retryOnError = true,
  }) async {
    return _executeWithRetry(
      () => _performDelete(path, data, queryParameters, token),
      retryOnError: retryOnError,
      path: path,
    );
  }

  Future<dynamic> _performDelete(
    String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  ) async {
    final options = _createOptions(token);

    final response = await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return response.data;
  }

  Future<dynamic> _executeWithRetry(
    Future<dynamic> Function() request, {
    required bool retryOnError,
    required String path,
  }) async {
    int retryCount = 0;

    while (retryCount < _maxRetries) {
      try {
        return await request();
      } catch (error, stackTrace) {
        final exception = ErrorHandler.handle(error, stackTrace);

        if (!retryOnError ||
            !exception.isRetryable ||
            retryCount >= _maxRetries - 1) {
          throw exception;
        }

        retryCount++;
        await Future.delayed(exception.retryDelay * (retryCount + 1));
      }
    }
  }

  Options _createOptions(String? token) {
    final options = Options();
    if (token != null) {
      options.headers?['Authorization'] = 'Bearer $token';
    }
    return options;
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

  void cancel() {
    _dio.close();
  }
}
