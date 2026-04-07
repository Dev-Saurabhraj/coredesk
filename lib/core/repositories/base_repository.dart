import 'package:coredesk/core/exceptions/exceptions.dart';
import 'package:coredesk/core/utils/error_handler.dart';

abstract class BaseRepository {
  Future<ApiResponseWrapper<T>> executeApi<T>(
    Future<dynamic> Function() apiCall, {
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await apiCall();
      final data = fromJson(response);
      return ApiResponseWrapper.success(data);
    } on AppException catch (e) {
      return ApiResponseWrapper.error(e);
    } catch (error, stackTrace) {
      final exception = ErrorHandler.handle(error, stackTrace);
      return ApiResponseWrapper.error(exception);
    }
  }

  Future<AsyncResult<T>> executeApiAsync<T>(
    Future<dynamic> Function() apiCall, {
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await apiCall();
      final data = fromJson(response);
      return AsyncResult.success(data);
    } on AppException catch (e) {
      return AsyncResult.error(e);
    } catch (error, stackTrace) {
      final exception = ErrorHandler.handle(error, stackTrace);
      return AsyncResult.error(exception);
    }
  }
}

class TemplateRepository extends BaseRepository {}
