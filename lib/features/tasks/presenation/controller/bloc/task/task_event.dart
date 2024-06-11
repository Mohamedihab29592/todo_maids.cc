import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable{
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllTasksEvent extends TaskEvent {


}

class FetchOwnTasksEvent extends TaskEvent{
  final int userId;
  const FetchOwnTasksEvent({required this.userId});
}

class FetchNextPageEvent extends TaskEvent {

}

class DeleteTaskEvent extends TaskEvent {

  final int todoId;

  const DeleteTaskEvent({required this.todoId});

  @override
  List<Object?> get props => [todoId];
}
class UpdateTaskEvent extends TaskEvent {
  final int todoId;
  final bool completed;

  const UpdateTaskEvent({required this.todoId, required this.completed});

  @override
  List<Object?> get props => [todoId];
}