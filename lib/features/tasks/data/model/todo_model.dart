
import '../../domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required super.id,
    required super.todo,
    required super.completed,
    required super.userId,
  });

  // Factory constructor to create a TodoModel from JSON
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  static List<TodoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TodoModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<TodoModel> todos) {
    return todos.map((todo) => todo.toJson()).toList();
  }
}
