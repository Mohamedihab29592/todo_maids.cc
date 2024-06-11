import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/base_use_cases/base_use_case.dart';
import '../../../../domain/use_cases/add_tasks_usecase.dart';
import 'manager_state.dart';


class ManagerCubit extends Cubit<ManagerStates> {
  final AddTodoUseCase addTodoUseCase;


  static ManagerCubit of(BuildContext context) => BlocProvider.of<ManagerCubit>(context);

  ManagerCubit(this.addTodoUseCase, ) : super(ManagerInitialState());

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

}
