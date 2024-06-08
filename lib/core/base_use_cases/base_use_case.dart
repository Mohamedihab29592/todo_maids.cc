import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/exceptions.dart';


abstract class BaseUseCase<T, Parameter> {
  Future<Either<ServerException, T>> call(Parameter parameter);
}

class NoParameters extends Equatable {
  const NoParameters();
  @override
  List<Object?> get props => [];
}

abstract class TwoParameters<T, parm1, parm2> {
  Future<Either<ServerException, T>> call(parm1 parameter1, parm2 parameter2);
}

abstract class NoParameter<T> {
  Future<Either<ServerException, T>> call();
}