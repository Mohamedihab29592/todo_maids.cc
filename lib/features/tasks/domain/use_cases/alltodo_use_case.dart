import 'package:dartz/dartz.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';

import '../../../../core/base_use_cases/base_use_case.dart';
import '../../../../core/error/exceptions.dart';
import '../repositories/base_alltodo_repository.dart';

class AllTodoUseCase implements BaseUseCase<List<TodoEntity>, AllTodoParameters> {
  final BaseTodoRepository allTodoRepository;

  AllTodoUseCase({required this.allTodoRepository});

  @override
  Future<Either<ServerException, List<TodoEntity>>> call(AllTodoParameters? parameters) async {
    try {
      final result = await allTodoRepository.getAllTodo(
        limit: parameters!.limit,
        skip: parameters.skip,
      );
      return result;
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }
}

