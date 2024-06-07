import 'package:dartz/dartz.dart';
import 'package:todo_task/core/utilies/constans.dart';
import '../../../../../core/error/error_model.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/helper/cache_helper.dart';
import '../../../../../core/network/dio.dart';
import '../../../domain/entities/user.dart';
import '../../model/user_model.dart';


abstract class BaseLoginRemoteDataSource {
  Future<Unit> login({required UserLoginEntity userLoginEntity});
}

class LoginRemoteDataSource implements BaseLoginRemoteDataSource {
  @override
  Future<Unit> login({required UserLoginEntity userLoginEntity}) async {
    var body = {
      'username': userLoginEntity.userName,
      'password': userLoginEntity.password,
      'expiresInMins': 30, // optional, defaults to 60
    };

    try {
      final response = await DioHelper.postData(
        url: AppConstants.login,
        data: body,
      );


      if (response.statusCode == 200) {
        final dioResponse = UserModel.fromJson(response.data);
        var token = dioResponse.token;
        CacheHelper cacheHelper = CacheHelper();
        await cacheHelper.writeToken(token);

        return unit;
      } else {
        final errorMessage = ErrorMessageModel(
          success: false,
          statusCode: response.statusCode ?? 0,
          statusMessage: response.data['error'] ?? 'Unknown error occurred',
        );
        throw ServerExceptions(errorMessageModel: errorMessage);
      }
    } catch (e) {
      // Handle network errors
      throw ServerExceptions(errorMessageModel: ErrorMessageModel(
        success: false,
        statusCode: 0,
        statusMessage: 'Network error: $e',
      ));
    }
  }
}
