import 'package:dio/dio.dart';
import 'package:coredesk/core/exceptions/index.dart';

class ErrorHandler {
  static AppException handle(dynamic error, [StackTrace? stackTrace]) {
    if (error is AppException) {
      return error;
    }

    if (error is DioException) {
      return _handleDioError(error, stackTrace);
    }

    return UnknownException(
      message: error.toString(),
      code: 'UNKNOWN_ERROR',
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  static AppException _handleDioError(
    DioException error,
    StackTrace? stackTrace,
  ) {
    final message = _getErrorMessage(error);
    final statusCode = error.response?.statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return TimeoutException(
          message: message,
          code: 'TIMEOUT_ERROR',
          originalError: error,
          stackTrace: stackTrace,
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          message: message,
          code: 'NETWORK_ERROR',
          originalError: error,
          stackTrace: stackTrace,
        );

      case DioExceptionType.badResponse:
        if (statusCode == 401 || statusCode == 403) {
          return AuthException(
            message: message,
            code: 'AUTH_ERROR',
            originalError: error,
            stackTrace: stackTrace,
          );
        }

        if (statusCode != null && statusCode >= 500) {
          return ServerException(
            message: message,
            code: 'SERVER_ERROR',
            statusCode: statusCode,
            originalError: error,
            stackTrace: stackTrace,
          );
        }

        if (statusCode != null && statusCode >= 400) {
          return ClientException(
            message: message,
            code: 'CLIENT_ERROR',
            statusCode: statusCode,
            originalError: error,
            stackTrace: stackTrace,
          );
        }

        return ServerException(
          message: message,
          code: 'SERVER_ERROR',
          statusCode: statusCode,
          originalError: error,
          stackTrace: stackTrace,
        );

      case DioExceptionType.cancel:
        return UnknownException(
          message: 'Request cancelled',
          code: 'REQUEST_CANCELLED',
          originalError: error,
          stackTrace: stackTrace,
        );

      case DioExceptionType.unknown:
        return UnknownException(
          message: message,
          code: 'UNKNOWN_ERROR',
          originalError: error,
          stackTrace: stackTrace,
        );

      case DioExceptionType.badCertificate:
        return NetworkException(
          message: 'Certificate validation failed',
          code: 'BAD_CERTIFICATE',
          originalError: error,
          stackTrace: stackTrace,
        );
    }
  }

  static String _getErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.receiveTimeout:
        return 'Server is not responding. Please try again later.';
      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';
      case DioExceptionType.connectionError:
        return 'Unable to connect to the server. Please check your internet connection.';
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 401) {
          return 'Your session has expired. Please login again.';
        }
        if (error.response?.statusCode == 403) {
          return 'You are not authorized to perform this action.';
        }
        if (error.response?.statusCode == 404) {
          return 'The requested resource was not found.';
        }
        if (error.response?.statusCode == 500) {
          return 'Server error. Please try again later.';
        }
        if (error.response?.statusCode == 429) {
          return 'Too many requests. Please wait a moment and try again.';
        }
        return 'An error occurred. Please try again.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.unknown:
        return 'An unknown error occurred. Please try again.';
      case DioExceptionType.badCertificate:
        return 'Certificate validation failed. Please try again.';
    }
  }

  static String getUserFriendlyMessage(AppException exception) {
    if (exception is TimeoutException) {
      return 'The server is taking too long to respond. Please try again.';
    }
    if (exception is NetworkException) {
      return 'Please check your internet connection and try again.';
    }
    if (exception is AuthException) {
      return 'Your session has expired. Please login again.';
    }
    if (exception is ServerException) {
      return 'Something went wrong on the server. Please try again later.';
    }
    if (exception is ClientException) {
      return exception.message;
    }
    if (exception is ValidationException) {
      return exception.message;
    }
    return exception.message;
  }
}

class ApiResponseWrapper<T> {
  final bool isSuccess;
  final T? data;
  final AppException? error;

  ApiResponseWrapper({required this.isSuccess, this.data, this.error});

  factory ApiResponseWrapper.success(T data) {
    return ApiResponseWrapper(isSuccess: true, data: data);
  }

  factory ApiResponseWrapper.error(AppException error) {
    return ApiResponseWrapper(isSuccess: false, error: error);
  }
}

class AsyncResult<T> {
  final T? data;
  final AppException? error;
  final bool isLoading;

  AsyncResult({this.data, this.error, this.isLoading = false});

  factory AsyncResult.loading() {
    return AsyncResult(isLoading: true);
  }

  factory AsyncResult.success(T data) {
    return AsyncResult(data: data);
  }

  factory AsyncResult.error(AppException error) {
    return AsyncResult(error: error);
  }

  bool get isSuccess => data != null && error == null;

  bool get isError => error != null;
}
