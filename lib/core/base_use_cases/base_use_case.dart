import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../features/tasks/domain/entities/todo_entity.dart';
import '../error/exceptions.dart';


abstract class BaseUseCase<T, Parameter> {
  Future<Either<ServerException, T>> call(Parameter parameter);
}



class NoParameters extends Equatable {
  const NoParameters();
  @override
  List<Object?> get props => [];
}

class AllTodoParameters {
  final int limit;
  final int skip;

  AllTodoParameters({required this.limit, required this.skip});
}
class OwnTodoParameters {
  final int userId;


  OwnTodoParameters({required this.userId});
}
abstract class NoParameter<T> {
  Future<Either<ServerException, T>> call();
}