import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/core/utilies/strings.dart';
import '../error/exceptions.dart';

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();

  factory DioHelper() {
    return _instance;
  }

  static Dio? _dio;

  DioHelper._internal() {
    BaseOptions baseOptions = BaseOptions(
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
        if (e.response != null) {
          debugPrint('Response data: ${e.response!.data}');
          debugPrint('Status code: ${e.response!.statusCode}');
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

  static Future<Response> getData({
    required String url,
  }) async {
    try {
      Response response = await _dio!.get(url);

      return response;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          debugPrint('Response data: ${e.response!.data}');
          debugPrint('Status code: ${e.response!.statusCode}');
          switch (e.response!.statusCode) {
            case 400:
              throw InvalidCredentialsException(e.response!.data['message']);
            case 401:
              throw InvalidCredentialsException(AppStrings.errorUnauthorized);
            case 403:
              throw ServerException(AppStrings.errorForbidden);
            case 404:
              throw ServerException(AppStrings.errorResource);
            case 500:
              throw ServerException(AppStrings.errorInternal);
            default:
              throw ServerException(
                  'Server error: ${e.response!.statusCode} ${e.response!.statusMessage}');
          }
        } else {
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
