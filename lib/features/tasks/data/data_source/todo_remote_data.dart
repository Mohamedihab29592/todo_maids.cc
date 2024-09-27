import 'package:todo_task/core/utilies/strings.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/helper/cache_helper.dart';
import '../../../../core/network/dio.dart';
import '../../../../core/utilies/constans.dart';
import '../model/todo_model.dart';
//update
abstract class BaseTodoRemoteDataSource {
  Future<List<TodoEntity>> getAllTodo({required int limit, required int skip});
  Future<List<TodoEntity>> getNextPage({required int limit, required int skip});
  Future<List<TodoEntity>> getOwnTodo({required int userId});
  Future<TodoEntity> updateTodo({required int todoId,required bool completed});
  Future<TodoEntity> addTodo({required String todo, required bool completed, required int userId});
  Future<TodoEntity> deleteTodo({required int todoId});

}

class TodoDataSource implements BaseTodoRemoteDataSource {
  late final CacheHelper cacheHelper = sl<CacheHelper>();

  @override
  Future<List<TodoEntity>> getAllTodo({
    required int limit,
    required int skip,
  }) async {
    List<TodoEntity> cachedTodos = await cacheHelper.readTodos(
        AppStrings.allTodosKey) ?? [];
    if (cachedTodos.isNotEmpty) {
      return cachedTodos;
    } else {
      final response = await DioHelper.getData(
        url: AppConstants.allTodoUrl(limit: limit, skip: skip),
      );
      final allTodos = (response.data['todos'] as List)
          .map((todoJson) => TodoModel.fromJson(todoJson))
          .toList();
      await cacheHelper.writeTodos(AppStrings.allTodosKey, allTodos);
      return allTodos;
    }
  }

  @override
  Future<List<TodoEntity>> getOwnTodo({
    required int userId,
  }) async {
    List<TodoEntity> cachedTodos = await cacheHelper.readTodos(
        AppStrings.ownTodosKey) ?? [];
    if (cachedTodos.isNotEmpty) {
      return cachedTodos;
    } else {
      final response = await DioHelper.getData(
        url: AppConstants.ownTodoUrl(userId: userId),
      );
      final ownTodos = (response.data['todos'] as List)
          .map((todoJson) => TodoModel.fromJson(todoJson))
          .toList();
      await cacheHelper.writeTodos(AppStrings.ownTodosKey, ownTodos);
      return ownTodos;
    }
  }

  @override
  Future<TodoEntity> updateTodo(
      {required int todoId, required bool completed}) async {
    Map<String, dynamic> updatedTodoData = {
      'completed': completed,
    };

    final response = await DioHelper.putData(
        url: AppConstants.editDeleteTodoUrl(todoId: todoId),
        data: updatedTodoData);
    final updateTodo = TodoModel.fromJson(response.data);


    return updateTodo;
  }

  @override
  Future<TodoEntity> addTodo({
    required String todo,
    required bool completed,
    required int userId,
  }) async {
    Map<String, dynamic> newTodoData = {
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };

    final response = await DioHelper.postData(
      url: AppConstants.addTodoUrl,
      data: newTodoData,
    );

    final addedTodo = TodoModel.fromJson(response.data);

    List<TodoEntity> existingTodos = await cacheHelper.readTodos(
        AppStrings.ownAddTodosKey) ?? [];

    existingTodos.add(addedTodo);

    await cacheHelper.writeAddTodos(AppStrings.ownAddTodosKey, existingTodos);

    return addedTodo;
  }

  @override
  Future<TodoEntity> deleteTodo({required int todoId}) async {
    final response = await DioHelper.deleteData(
        url: AppConstants.editDeleteTodoUrl(todoId: todoId));
    final deletedTodo = TodoModel.fromJson(response.data);
    return deletedTodo;
  }

  @override
  Future<List<TodoEntity>> getNextPage(
      {required int limit, required int skip}) async {
    final response = await DioHelper.getData(
      url: AppConstants.allTodoUrl(limit: limit, skip: skip),
    );
    final nextTodo = (response.data['todos'] as List)
        .map((todoJson) => TodoModel.fromJson(todoJson))
        .toList();
    await cacheHelper.writeTodos(AppStrings.allTodosKey, nextTodo);
    return nextTodo;
  }
}