import 'package:dartz/dartz.dart';
import 'package:todo_task/core/utilies/strings.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/helper/cache_helper.dart';
import '../../../../core/network/dio.dart';
import '../../../../core/utilies/constans.dart';
import '../model/todo_model.dart';

abstract class BaseTodoRemoteDataSource {
  Future<List<TodoEntity>> getAllTodo({required int limit, required int skip});
  Future<List<TodoEntity>> getOwnTodo({required int userId});
}

class TodoDataSource implements BaseTodoRemoteDataSource {
  final CacheHelper cacheHelper = sl<CacheHelper>();

  @override
  Future<List<TodoEntity>> getAllTodo({
    required int limit,
    required int skip,
  }) async {
   /* if (await cacheHelper.hasTodos(AppStrings.allTodosKey)) {
      final cachedTodos = await cacheHelper.readTodos(AppStrings.allTodosKey);
      if (cachedTodos != null) {
        return cachedTodos;
      }
    }*/

    final response = await DioHelper.getData(
      url: AppConstants.allTodoUrl(limit: limit, skip: skip),
    );
    print(response.data);
    final allTodos = (response.data['todos'] as List)
        .map((todoJson) => TodoModel.fromJson(todoJson))
        .toList();

    await cacheHelper.writeTodos(AppStrings.allTodosKey, allTodos);

    return allTodos;
  }

  @override
  Future<List<TodoEntity>> getOwnTodo({
    required int userId,
  }) async {
    if (await cacheHelper.hasTodos(AppStrings.ownTodosKey)) {
      final cachedTodos = await cacheHelper.readTodos(AppStrings.ownTodosKey);
      if (cachedTodos != null) {
        return cachedTodos;
      }
    }

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