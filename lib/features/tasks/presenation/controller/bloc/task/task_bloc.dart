import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';
import 'package:todo_task/features/tasks/presenation/controller/bloc/task/task_event.dart';
import '../../../../../../core/base_use_cases/base_use_case.dart';
import '../../../../../../core/utilies/enum.dart';
import '../../../../domain/use_cases/alltodo_use_case.dart';
import '../../../../domain/use_cases/own_tasks_usecase.dart';
import 'dart:async';
part 'task_state.dart';


class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AllTodoUseCase allTodoUseCase;

  final OwnTasksUseCase ownTasksUseCase;

  int totalFetchedItems = 10;
  final int limit = 10;
  TaskBloc(this.allTodoUseCase, this.ownTasksUseCase, )
      : super( const TaskState()) {
    on<FetchAllTasksEvent>(_mapFetchAllTasksEventToState);
    on<FetchOwnTasksEvent>(_mapFetchOwnTasksEventToState);
    on<FetchNextPageEvent>(_mapFetchNextPageEventToState);



  }

  FutureOr<void> _mapFetchAllTasksEventToState(FetchAllTasksEvent event, Emitter<TaskState> emit) async {
    final result = await allTodoUseCase.call(AllTodoParameters(limit: 10, skip: 0));
    result.fold(
          (l) =>emit(state.copyWith(
              allTodoStates: RequestState.error, allTodoMessage: l.message)),
            (r) {
              emit(state.copyWith(
                allTodoTasks: r,
                allTodoStates: RequestState.loaded,
              ));
            }

    );

  }

  FutureOr<void> _mapFetchOwnTasksEventToState(FetchOwnTasksEvent event, Emitter<TaskState> emit) async {
    final result = await ownTasksUseCase.call(OwnTodoParameters(userId: event.userId));

    result.fold(
            (l) => emit(state.copyWith(
            ownTodoStates: RequestState.error,
            ownTodoMessage: l.message
        )),
            (r) {
          final completedTasks = r.where((task) => task.completed).toList();
          final unCompletedTasks = r.where((task) => !task.completed).toList();

          emit(state.copyWith(
            ownTodoTasks: r,
            completedTodoTasks: completedTasks,
            unCompletedTodoTasks: unCompletedTasks,
            ownTodoStates: RequestState.loaded,
          ));
        }
    );
  }  FutureOr<void> _mapFetchNextPageEventToState(FetchNextPageEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isFetchingMore: true));

    final result = await allTodoUseCase.call(AllTodoParameters(limit: limit, skip: totalFetchedItems));

    result.fold(
          (l) => emit(state.copyWith(isFetchingMore: false, allTodoStates: RequestState.error, allTodoMessage: l.message)),
          (r) {
        if (r.isEmpty) {
          emit(state.copyWith(isFetchingMore: false));
        } else {
          final List<TodoEntity> newTasks = r.where((task) => !state.allTodoTasks.contains(task)).toList();
          totalFetchedItems += newTasks.length;
          final allTasks = List<TodoEntity>.from(state.allTodoTasks)..addAll(newTasks);

          emit(state.copyWith(
            allTodoTasks: allTasks,
            allTodoStates: RequestState.loaded,
            isFetchingMore: false,
          ));
        }
      },
    );
  }



}
