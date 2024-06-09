import 'package:dartz/dartz.dart';
import 'package:todo_task/features/tasks/domain/repositories/base_alltodo_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/todo_entity.dart';
import '../data_source/todo_remote_data.dart';



class AllTodoRepositoryImpl implements BaseAllTodoRepository {
  final BaseTodoRemoteDataSource allTodoRemoteDataSource;

  AllTodoRepositoryImpl({required this.allTodoRemoteDataSource});


  @override
  Future<Either<ServerException, List<TodoEntity>>> getAllTodo({required int limit,required int skip}) async {
    List<TodoEntity> tasks = await allTodoRemoteDataSource.getAllTodo(limit:limit ,skip:skip );
    return  Right(tasks);

  }
}