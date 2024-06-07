
import 'package:dartz/dartz.dart';
import 'package:todo_task/features/auth/domain/entities/user.dart';

import '../../../../core/error/failure.dart';

abstract class BaseLoginRepository {
  Future<Either<Failure, Unit>> login(
      {required UserLoginEntity userLoginEntity});
}