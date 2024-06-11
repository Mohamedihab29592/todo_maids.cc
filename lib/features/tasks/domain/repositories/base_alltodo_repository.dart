import 'package:dartz/dartz.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';

import '../../../../core/error/exceptions.dart';

abstract class BaseTodoRepository {
  Future<Either<ServerException, List<TodoEntity>>> getAllTodo(
      {required int limit, required int skip});

  Future<Either<ServerException, List<TodoEntity>>> getNextTodo(
      {required int limit, required int skip});

  Future<Either<ServerException, List<TodoEntity>>> getOwnTodo(
      {required int userId});

  Future<Either<ServerException, TodoEntity>> addTodo(
      {required String todo, required bool completed, required int userId});

  Future<Either<ServerException, TodoEntity>> deleteTodo(
      {required int todoId});

  Future<Either<ServerException, TodoEntity>> updateTodo(
      {required int todoId, required bool completed});

}


