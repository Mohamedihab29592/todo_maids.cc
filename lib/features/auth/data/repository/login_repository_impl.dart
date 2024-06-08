import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/base_login_repository.dart';
import '../data_source/remote_data/remote_data.dart';


class LoginRepositoryImpl implements BaseLoginRepository {
  final BaseLoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<ServerException, Unit>> login(
      {required UserLoginEntity userLoginEntity}) async {
    await loginRemoteDataSource.login(userLoginEntity: userLoginEntity,);
    return const Right(unit);
  }
}