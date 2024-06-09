import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable{
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllTasksEvent extends TaskEvent {


}

class FetchOwnTasksEvent extends TaskEvent{}

class FetchNextPageEvent extends TaskEvent {

}