abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;

  AppException({
    required this.message,
    this.code,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() => message;

  bool get isRetryable => false;

  Duration get retryDelay => Duration.zero;
}

class ServerException extends AppException {
  final int? statusCode;

  ServerException({
    required String message,
    String? code,
    dynamic originalError,
    this.statusCode,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code,
         originalError: originalError,
         stackTrace: stackTrace,
       );

  @override
  bool get isRetryable => statusCode != null && statusCode! >= 500;

  @override
  Duration get retryDelay => Duration(seconds: 2);
}

class NetworkException extends AppException {
  NetworkException({
    required String message,
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code,
         originalError: originalError,
         stackTrace: stackTrace,
       );

  @override
  bool get isRetryable => true;

  @override
  Duration get retryDelay => Duration(seconds: 1);
}

class TimeoutException extends AppException {
  TimeoutException({
    required String message,
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code,
         originalError: originalError,
         stackTrace: stackTrace,
       );

  @override
  bool get isRetryable => true;

  @override
  Duration get retryDelay => Duration(seconds: 3);
}

class AuthException extends AppException {
  AuthException({
    required String message,
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code,
         originalError: originalError,
         stackTrace: stackTrace,
       );

  @override
  bool get isRetryable => false;
}

class CacheException extends AppException {
  CacheException({
    required String message,
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code,
         originalError: originalError,
         stackTrace: stackTrace,
       );

  @override
  bool get isRetryable => false;
}

class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  ValidationException({
    required String message,
    String? code,
    dynamic originalError,
    this.fieldErrors,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code,
         originalError: originalError,
         stackTrace: stackTrace,
       );

  @override
  bool get isRetryable => false;
}

class ClientException extends AppException {
  final int? statusCode;

  ClientException({
    required String message,
    String? code,
    dynamic originalError,
    this.statusCode,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code,
         originalError: originalError,
         stackTrace: stackTrace,
       );

  @override
  bool get isRetryable => false;
}

class UnknownException extends AppException {
  UnknownException({
    required String message,
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code,
         originalError: originalError,
         stackTrace: stackTrace,
       );

  @override
  bool get isRetryable => false;
}
