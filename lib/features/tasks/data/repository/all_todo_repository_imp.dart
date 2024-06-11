import 'package:dartz/dartz.dart';
import 'package:todo_task/features/tasks/domain/repositories/base_alltodo_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/todo_entity.dart';
import '../data_source/todo_remote_data.dart';



class TodoRepositoryImpl implements BaseTodoRepository {
  final BaseTodoRemoteDataSource todoRemoteDataSource;

  TodoRepositoryImpl({required this.todoRemoteDataSource});


  @override
  Future<Either<ServerException, List<TodoEntity>>> getAllTodo({required int limit,required int skip}) async {
    List<TodoEntity> tasks = await todoRemoteDataSource.getAllTodo(limit:limit ,skip:skip );
    return  Right(tasks);

  }
  @override
  Future<Either<ServerException, List<TodoEntity>>> getOwnTodo({required int userId}) async {
    List<TodoEntity> tasks = await todoRemoteDataSource.getOwnTodo(userId:userId  );
    return  Right(tasks);

  }
  @override
  Future<Either<ServerException, TodoEntity>> addTodo({required String todo, required bool completed, required int userId}) async{
     TodoEntity tasks = await todoRemoteDataSource.addTodo(todo: todo,completed: completed,userId: userId);
    return  Right(tasks);
  }

  @override
  Future<Either<ServerException, TodoEntity>> deleteTodo({required int todoId}) async{
    TodoEntity tasks = await todoRemoteDataSource.deleteTodo(todoId: todoId,);
    return  Right(tasks);
  }



  @override
  Future<Either<ServerException,TodoEntity>> updateTodo({required int todoId, required bool completed}) async{
    TodoEntity tasks = await todoRemoteDataSource.updateTodo(todoId: todoId,completed: completed);
    return  Right(tasks);
  }

  @override
  Future<Either<ServerException, List<TodoEntity>>> getNextTodo({required int limit, required int skip})async {
    List<TodoEntity> tasks = await todoRemoteDataSource.getNextPage(limit:limit ,skip:skip );
    return  Right(tasks);
  }
}