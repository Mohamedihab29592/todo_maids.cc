import 'package:dartz/dartz.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';

import '../../../../core/base_use_cases/base_use_case.dart';
import '../../../../core/error/exceptions.dart';
import '../repositories/base_alltodo_repository.dart';

class AddTodoUseCase implements BaseUseCase<TodoEntity, AddTodoParameters> {
  final BaseTodoRepository addTodoTasksRepo;

  AddTodoUseCase({required this.addTodoTasksRepo});

  @override
  Future<Either<ServerException, TodoEntity>> call(AddTodoParameters parameters) async {
    try {
      final result = await addTodoTasksRepo.addTodo(todo: parameters.todo, completed: parameters.completed, userId: parameters.userId);
      return result;
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }
}

