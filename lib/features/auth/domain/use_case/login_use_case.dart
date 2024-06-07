
import 'package:dartz/dartz.dart';

import '../../../../core/base_use_cases/base_use_case.dart';
import '../../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/base_login_repository.dart';

class LoginUseCase implements BaseUseCase<Unit, UserLoginEntity> {
  final BaseLoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, Unit>> call(UserLoginEntity userLoginEntity) async {
    try {
      final result = await loginRepository.login(userLoginEntity: userLoginEntity);
      return result;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}