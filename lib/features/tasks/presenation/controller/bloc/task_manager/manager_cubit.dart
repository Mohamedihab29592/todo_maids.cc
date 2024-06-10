import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/base_use_cases/base_use_case.dart';
import '../../../../domain/use_cases/add_tasks_usecase.dart';
import '../../../../domain/use_cases/delete_tasks_usecase.dart';
import '../../../../domain/use_cases/update_tasks_usecase.dart';
import 'manager_state.dart';


class ManagerCubit extends Cubit<ManagerStates> {
  final AddTodoUseCase addTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;

  static ManagerCubit of(BuildContext context) => BlocProvider.of<ManagerCubit>(context);

  ManagerCubit(this.deleteTodoUseCase, this.addTodoUseCase, this.updateTodoUseCase) : super(ManagerInitialState());

  Future<void> addTask({
    required String todo,
    required int userId,
    required bool completed,
  }) async {
    emit(AddTaskLoadingState());
    final result = await addTodoUseCase.call(AddTodoParameters(userId: userId, todo: todo, completed: completed));
    result.fold(
          (failure) {
        emit(AddTaskErrorState(failure.message));
      },
          (newTask) {
        emit(AddTaskSuccessState(task: newTask));
      },
    );
  }

  Future<void> updateTask({
    required int todoId,
    required bool completed,
  }) async {
    emit(UpdateLoadingState());
    final result = await updateTodoUseCase.call(UpdateTodoParameters(todoId: todoId, completed: completed));
    result.fold(
          (failure) {
        emit(UpdateErrorState(failure.message));
      },
          (updatedTask) {
        emit(UpdateSuccessState(task: updatedTask));
      },
    );
  }

  Future<void> deleteTask({required int todoId}) async {
    emit(DeleteLoadingState());
    final result = await deleteTodoUseCase.call(DeleteTodoParameters(todoId: todoId));
    result.fold(
          (failure) {
        emit(DeleteErrorState(failure.message));
      },
          (_) {
        emit(DeleteSuccessState());
      },
    );
  }
}
