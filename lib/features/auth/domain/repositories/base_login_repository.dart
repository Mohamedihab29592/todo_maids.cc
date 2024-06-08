
import 'package:dartz/dartz.dart';
import 'package:todo_task/features/auth/domain/entities/user.dart';

import '../../../../core/error/exceptions.dart';

abstract class BaseLoginRepository {
  Future<Either<ServerException, Unit>> login(
      {required UserLoginEntity userLoginEntity});
}