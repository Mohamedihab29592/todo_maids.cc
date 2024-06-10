import 'package:dartz/dartz.dart';

import '../../../../core/base_use_cases/base_use_case.dart';
import '../../../../core/error/exceptions.dart';
import '../entities/todo_entity.dart';
import '../repositories/base_alltodo_repository.dart';

class UpdateTodoUseCase implements BaseUseCase<TodoEntity, UpdateTodoParameters> {
  final BaseTodoRepository updateTodoTasksRepo;

  UpdateTodoUseCase({required this.updateTodoTasksRepo});

  @override
  Future<Either<ServerException, TodoEntity>> call(UpdateTodoParameters parameters) async {
    try {
      final result = await updateTodoTasksRepo.updateTodo(todoId: parameters.todoId,completed: parameters.completed);
      return result;
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }
}