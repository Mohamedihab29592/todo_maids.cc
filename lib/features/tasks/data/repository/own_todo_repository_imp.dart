import 'package:dartz/dartz.dart';
import 'package:todo_task/features/tasks/domain/repositories/base_alltodo_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/todo_entity.dart';
import '../data_source/todo_remote_data.dart';



class OwnTodoRepositoryImp implements BaseOwnTodoRepository {
  final BaseTodoRemoteDataSource ownTodoRemoteDataSource;

  OwnTodoRepositoryImp({required this.ownTodoRemoteDataSource});


  @override
  Future<Either<ServerException, List<TodoEntity>>> getOwnTodo({required int userId}) async {
    List<TodoEntity> tasks = await ownTodoRemoteDataSource.getOwnTodo(userId:userId  );
    return  Right(tasks);

  }
}