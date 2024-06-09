import 'package:dartz/dartz.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';

import '../../../../core/error/exceptions.dart';

abstract class BaseAllTodoRepository {
  Future<Either<ServerException, List<TodoEntity>>> getAllTodo({required int limit , required int skip});
}
abstract class BaseOwnTodoRepository {
  Future<Either<ServerException, List<TodoEntity>>> getOwnTodo({required int userId});
}
