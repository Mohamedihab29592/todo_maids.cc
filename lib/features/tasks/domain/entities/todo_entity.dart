class TodoEntity {
  final int id;
  final String todo;
  final bool completed;
  final int userId;
  final bool isDeleted;


  TodoEntity({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
    required this.isDeleted,
  });


}