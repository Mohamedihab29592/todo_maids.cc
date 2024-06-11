import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';
import 'package:todo_task/features/tasks/presenation/controller/bloc/task/task_event.dart';
import '../../../../../../core/base_use_cases/base_use_case.dart';
import '../../../../../../core/utilies/enum.dart';
import '../../../../domain/use_cases/alltodo_use_case.dart';
import '../../../../domain/use_cases/delete_tasks_usecase.dart';
import '../../../../domain/use_cases/own_tasks_usecase.dart';
import 'dart:async';

import '../../../../domain/use_cases/update_tasks_usecase.dart';
part 'task_state.dart';


class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AllTodoUseCase allTodoUseCase;

  final OwnTasksUseCase ownTasksUseCase;

  final DeleteTodoUseCase deleteTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;

  int totalFetchedItems = 10;
  final int limit = 10;
  TaskBloc(this.allTodoUseCase, this.ownTasksUseCase, this.deleteTodoUseCase, this.updateTodoUseCase, )
      : super( const TaskState()) {
    on<FetchAllTasksEvent>(_mapFetchAllTasksEventToState);
    on<FetchOwnTasksEvent>(_mapFetchOwnTasksEventToState);
    on<FetchNextPageEvent>(_mapFetchNextPageEventToState);
    on<DeleteTaskEvent>(_mapDeleteTaskEventToState);
    on<UpdateTaskEvent>(_mapUpdateTaskEventToState);


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


          emit(state.copyWith(
            ownTodoTasks: r,
            ownTodoStates: RequestState.loaded,
          ));
        }
    );
  }

  FutureOr<void> _mapFetchNextPageEventToState(FetchNextPageEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isFetchingMore: true));

    final result = await allTodoUseCase.call(AllTodoParameters(limit: limit, skip: totalFetchedItems));

    result.fold(
          (l) => emit(state.copyWith(isFetchingMore: false, allTodoStates: RequestState.error, allTodoMessage: l.message)),
          (r) {
            if (r.isEmpty) {
              emit(state.copyWith(isFetchingMore: false, hasReachedMax: true));
            } else {
              final List<TodoEntity> newTasks = r.where((task) => !state.allTodoTasks.contains(task)).toList();
              totalFetchedItems += newTasks.length;
              final allTasks = List<TodoEntity>.from(state.allTodoTasks)..addAll(newTasks);

              emit(state.copyWith(
                allTodoTasks: allTasks,
                allTodoStates: RequestState.loaded,
                isFetchingMore: false,
                hasReachedMax: false, // Resetting the flag as there may be more tasks
              ));
            }
      },
    );
  }



  FutureOr<void> _mapDeleteTaskEventToState(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    final result = await deleteTodoUseCase.call(DeleteTodoParameters(todoId: event.todoId));

    result.fold(
          (failure) {
        emit(state.copyWith(isDeletingStates: RequestState.error, deleteErrorMessage: failure.message));
      },
          (_) async {
        // Update the cache after successful deletion
        List<TodoEntity> allTasks = List<TodoEntity>.from(state.allTodoTasks);
        List<TodoEntity> ownTasks = List<TodoEntity>.from(state.ownTodoTasks);
        allTasks.removeWhere((task) => task.id == event.todoId);
        ownTasks.removeWhere((task) => task.id == event.todoId);

        // Update the state
        emit(state.copyWith(
          isDeletingStates:  RequestState.loaded,
          allTodoTasks: allTasks,
          ownTodoTasks: ownTasks,
        ));
        add(FetchNextPageEvent());
      },
    );
  }

  FutureOr<void> _mapUpdateTaskEventToState(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isUpdatingStates: RequestState.loading));

    final result = await updateTodoUseCase.call(UpdateTodoParameters(todoId: event.todoId, completed: event.completed));

    result.fold(
          (failure) {
        emit(state.copyWith(isUpdatingStates: RequestState.error, updateErrorMessage: failure.message));
      },
          (updatedTask) async {
        // Create new lists to update state immutably
        List<TodoEntity> allTasks = List<TodoEntity>.from(state.allTodoTasks);
        List<TodoEntity> ownTasks = List<TodoEntity>.from(state.ownTodoTasks);

        // Update the task in the allTasks list
        final indexAllTasks = allTasks.indexWhere((task) => task.id == event.todoId);
        if (indexAllTasks != -1) {
          allTasks[indexAllTasks] = updatedTask;
        }

        // Update the task in the ownTasks list
        final indexOwnTasks = ownTasks.indexWhere((task) => task.id == event.todoId);
        if (indexOwnTasks != -1) {
          ownTasks[indexOwnTasks] = updatedTask;
        }


        // Update the state
        emit(state.copyWith(
          isUpdatingStates: RequestState.loaded,
          allTodoTasks: allTasks,
          ownTodoTasks: ownTasks,
        ));
      },
    );
  }

}


