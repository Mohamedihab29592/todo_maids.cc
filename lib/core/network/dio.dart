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

  static Future<Response> _handleError(DioException e) {
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
        case 429:
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
        return _handleError(e);
      } else {
        debugPrint('Unexpected error: $e');
        throw ServerException('Unexpected error: $e');
      }    }
  }

  static Future<Response> getData({
    required String ?url,
  }) async {
    try {
      Response response = await _dio!.get(url!);

      return response;
    } catch (e) {
      if (e is DioException) {
        return _handleError(e);
      } else {
        debugPrint('Unexpected error: $e');
        throw ServerException('Unexpected error: $e');
      }
    }
  }


  static Future<Response> putData({
    required String url,
    required dynamic data,
  }) async {
    try {
      Response response = await _dio!.put(url, data: data);
      return response;
    } catch (e) {
      if (e is DioException) {
        return _handleError(e);
      } else {
        debugPrint('Unexpected error: $e');
        throw ServerException('Unexpected error: $e');
      }
    }
    }

  static Future<Response> deleteData({
    required String url,
  }) async {
    try {
      Response response = await _dio!.delete(url);
      return response;
    } catch (e) {
      if (e is DioException) {
        return _handleError(e);
      } else {
        debugPrint('Unexpected error: $e');
        throw Exception('Unexpected error: $e');
      }
    }
  }
  }

