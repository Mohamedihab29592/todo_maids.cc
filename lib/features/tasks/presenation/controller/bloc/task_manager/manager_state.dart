

import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';

abstract class ManagerStates{}

class ManagerInitialState extends ManagerStates{}



class AddTaskLoadingState extends ManagerStates{}
class AddTaskSuccessState extends ManagerStates {
  final TodoEntity task;
  AddTaskSuccessState({required this.task});

}
class AddTaskErrorState extends ManagerStates{
  final String error;
  AddTaskErrorState(this.error);
}











