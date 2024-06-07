import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/base_login_repository.dart';
import '../data_source/remote_data/remote_data.dart';


class LoginRepositoryImpl implements BaseLoginRepository {
  final BaseLoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> login(
      {required UserLoginEntity userLoginEntity}) async {
    try {
      await loginRemoteDataSource.login(userLoginEntity: userLoginEntity,);
      return const Right(unit);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }
}