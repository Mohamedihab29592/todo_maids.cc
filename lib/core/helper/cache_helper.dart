import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_task/core/utilies/strings.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';
import '../../features/tasks/data/model/todo_model.dart';


class CacheHelper {

  Future<String?> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppStrings.token);
  }
  Future<int?> readUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(AppStrings.userId);
  }
  Future<void> writeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppStrings.token, token);
  }
  Future<void> writeUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppStrings.userId, userId);
  }

  Future<void>clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppStrings.token);
  }

  Future<void> writeTodos(String key, List<TodoModel> todos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(TodoModel.toJsonList(todos));
    await prefs.setString(key, jsonString);
  }
  Future<void> writeAddTodos(String key, List<TodoEntity> todos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(todos);
    await prefs.setString(key, jsonString);
  }
  Future<List<TodoModel>?> readTodos(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return TodoModel.fromJsonList(jsonList);
    }
    return null;
  }

  Future<bool> hasTodos(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    return jsonString != null && jsonString.isNotEmpty;
  }

  Future<void> appendTodos(String key, List<TodoModel> newTodos) async {
    List<TodoModel>? currentTodos = await readTodos(key);
    currentTodos ??= [];

    final Set<TodoModel> todoSet = {...currentTodos, ...newTodos};

    await writeTodos(key, todoSet.toList());
  }

  Future<void> clearTodos(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }


}
