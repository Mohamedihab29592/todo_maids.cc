import 'package:dartz/dartz.dart';

import '../../../../core/base_use_cases/base_use_case.dart';
import '../../../../core/error/exceptions.dart';
import '../entities/todo_entity.dart';
import '../repositories/base_alltodo_repository.dart';

class DeleteTodoUseCase implements BaseUseCase<TodoEntity, DeleteTodoParameters> {
  final BaseTodoRepository deleteTodoTasksRepo;

  DeleteTodoUseCase({required this.deleteTodoTasksRepo});

  @override
  Future<Either<ServerException, TodoEntity>> call(DeleteTodoParameters parameters) async {
    try {
      final result = await deleteTodoTasksRepo.deleteTodo(todoId: parameters.todoId);
      return result;
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }
}