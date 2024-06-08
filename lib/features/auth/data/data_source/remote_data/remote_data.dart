import 'package:dartz/dartz.dart';
import 'package:todo_task/core/utilies/constans.dart';
import '../../../../../core/di/service_locator.dart';
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
    final response = await DioHelper.postData(
      url: AppConstants.login,
      data: body,
    );
    final dioResponse = UserModel.fromJson(response.data);
    var token = dioResponse.token;
    final cacheHelper = sl<CacheHelper>();
    await cacheHelper.writeToken(token);

    return unit;
  }
}
