import 'package:dartz/dartz.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';
import '../../../../core/base_use_cases/base_use_case.dart';
import '../../../../core/error/exceptions.dart';
import '../repositories/base_alltodo_repository.dart';

class OwnTasksUseCase implements BaseUseCase<List<TodoEntity>, OwnTodoParameters> {
  final BaseTodoRepository ownTodoRepository;

  OwnTasksUseCase({required this.ownTodoRepository});

  @override
  Future<Either<ServerException, List<TodoEntity>>> call(OwnTodoParameters parameters) async {
    try {
      final result = await ownTodoRepository.getOwnTodo(
        userId: parameters.userId
      );
      return result;
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }
}

