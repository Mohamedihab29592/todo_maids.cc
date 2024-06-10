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

class AllTodoParameters {
  final int limit;
  final int skip;

  AllTodoParameters({required this.limit, required this.skip});
}
class OwnTodoParameters {
  final int userId;


  OwnTodoParameters({required this.userId});
}

class AddTodoParameters {
  final String todo;
  final bool completed ;
 final int  userId;


  AddTodoParameters({required this.userId,required this.todo,required this.completed, });
}

class DeleteTodoParameters {
  final int todoId;


  DeleteTodoParameters({required this.todoId});
}

class UpdateTodoParameters {
  final int todoId;
  final bool completed;

  UpdateTodoParameters({required this.todoId, required this.completed});
}

abstract class NoParameter<T> {
  Future<Either<ServerException, T>> call();
}