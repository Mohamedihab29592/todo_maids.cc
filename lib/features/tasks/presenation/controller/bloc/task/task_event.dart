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