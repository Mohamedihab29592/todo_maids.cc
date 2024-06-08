import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/core/utilies/strings.dart';
import '../error/exceptions.dart';
import '../utilies/constans.dart';

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();

  factory DioHelper() {
    return _instance;
  }

  static Dio? _dio;

  DioHelper._internal() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
      contentType: "application/json",
    );

    _dio = Dio(baseOptions);
    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Include the Content-Type header for every request
        options.headers["Content-Type"] = "application/json";
        return handler.next(options);
      },
    ));
  }

  static Future<Response> postData({
    required String url,
    required dynamic data,
  }) async {
    try {
      Response response = await _dio!.post(url, data: data);
      return response;
    } catch (e) {
      if (e is DioException) {
        // Handle DioException which is usually related to HTTP errors
        if (e.response != null) {
          debugPrint('Response data: ${e.response!.data}');
          debugPrint('Status code: ${e.response!.statusCode}');

          // Check for specific status codes
          switch (e.response!.statusCode) {
            case 400:
            // Invalid credentials
              throw InvalidCredentialsException(e.response!.data['message']);
            case 401:
            // Unauthorized
              throw InvalidCredentialsException(AppStrings.errorUnauthorized);
            case 403:
            // Forbidden
              throw ServerException(AppStrings.errorForbidden);
            case 404:
            // Not found
              throw ServerException(AppStrings.errorResource);
            case 500:
            // Internal server error
              throw ServerException(AppStrings.errorInternal);
            default:
            // Other server errors
              throw ServerException(
                  'Server error: ${e.response!.statusCode} ${e.response!.statusMessage}');
          }
        } else {
          // No response from server, it's a network issue
          debugPrint('Network error: ${e.message}');
          throw NetworkException(AppStrings.errorNetwork);
        }
      } else {
        // Other types of errors, rethrow or handle specifically
        debugPrint('Unexpected error: $e');
        throw ServerException('Unexpected error: $e');
      }
    }
  }


}