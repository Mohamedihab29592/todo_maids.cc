import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../helper/cache_helper.dart';
import '../utilies/constans.dart';
CacheHelper cacheHelper = CacheHelper();

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();

  factory DioHelper() {
    return _instance;
  }

  static Dio? _dio;
  static CacheHelper cacheHelper = CacheHelper();

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
    required data,
  }) async {
    try {
      Response response = await _dio!.post(url, data: data,);
      return response;
    } catch (e) {
      // Print stack trace to get more information about the error

      if (e is DioException) {
        // If DioError, it means an HTTP error occurred
        if (e.response != null) {
          // There is a response with data, debugPrint it for analysis
          debugPrint('Response data: ${e.response!.data}');
        } else {
          // No response available, debugPrint the error message
          debugPrint('Error message: ${e.message}');
        }
        // Throw the DioError to handle it in the caller function if needed
        rethrow;
      } else {
        // Other types of errors
        debugPrint('Error: $e');
        rethrow;
      }
    }
  }


  static Future<Response> patchData({
    required String url,
    required data,
  }) async {
    try {
      String? token = await cacheHelper.readToken();
      _dio!.options.headers = {
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio!.patch(url, data: data);
      return response;
    } catch (e) {
      if (e is DioException) {
        // If DioError, it means an HTTP error occurred
        if (e.response != null) {
          // There is a response with data, debugPrint it for analysis
          debugPrint('Response data: ${e.response!.data}');
        } else {
          // No response available, debugPrint the error message
          debugPrint('Error message: ${e.message}');
        }
        // Throw the DioError to handle it in the caller function if needed
        rethrow;
      } else {
        // Other types of errors
        debugPrint('Error: $e');
        rethrow;
      }
    }
  }

  static Future<Response> getData({
    required String url,
  }) async {
    try {
      String ? token = await cacheHelper.readToken();
      _dio!.options.headers = {
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio!.get(url);
      return response;
    } catch (e) {
      if (e is DioException) {
        // If DioError, it means an HTTP error occurred
        if (e.response != null) {
          // There is a response with data, debugPrint it for analysis
          debugPrint('Response data: ${e.response!.data}');
        } else {
          // No response available, debugPrint the error message
          debugPrint('Error message: ${e.message}');
        }
        // Throw the DioError to handle it in the caller function if needed
        rethrow;
      } else {
        // Other types of errors
        debugPrint('Error: $e');
        rethrow;
      }
    }
  }

}