import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_task/core/utilies/enum.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';
import 'package:todo_task/features/tasks/domain/use_cases/alltodo_use_case.dart';
import 'package:todo_task/features/tasks/domain/use_cases/delete_tasks_usecase.dart';
import 'package:todo_task/features/tasks/domain/use_cases/get_next_page_usecase.dart';
import 'package:todo_task/features/tasks/domain/use_cases/own_tasks_usecase.dart';
import 'package:todo_task/features/tasks/domain/use_cases/update_tasks_usecase.dart';
import 'package:todo_task/features/tasks/presenation/controller/bloc/task/task_bloc.dart';
import 'package:todo_task/features/tasks/presenation/controller/bloc/task/task_event.dart';

class MockAllTodoUseCase extends Mock implements AllTodoUseCase {}
class MoackNextTodoUseCase extends Mock implements NextTodoUseCase {}

class MockOwnTasksUseCase extends Mock implements OwnTasksUseCase {}
class MockUpdateTasksUseCase extends Mock implements UpdateTodoUseCase {}
class MockDeleteTasksUseCase extends Mock implements DeleteTodoUseCase {}

void main() {
  late TaskBloc taskBloc;
  late AllTodoUseCase mockAllTodoUseCase;
  late NextTodoUseCase mockNextTodoUseCase;
  late OwnTasksUseCase mockOwnTasksUseCase;
  late UpdateTodoUseCase mockUpdateTasksUseCase;
  late DeleteTodoUseCase mockUDeleteTasksUseCase;


  setUp(() {
    mockAllTodoUseCase = MockAllTodoUseCase();
    mockNextTodoUseCase = MoackNextTodoUseCase();
    mockOwnTasksUseCase = MockOwnTasksUseCase();
    mockOwnTasksUseCase = MockOwnTasksUseCase();
    mockUpdateTasksUseCase = MockUpdateTasksUseCase();
    mockUDeleteTasksUseCase = MockDeleteTasksUseCase();
    taskBloc = TaskBloc(mockAllTodoUseCase, mockOwnTasksUseCase,mockUDeleteTasksUseCase,mockUpdateTasksUseCase,mockNextTodoUseCase);
  });

  final testTodos = [
    TodoEntity(id: 1, todo: 'Test Todo 1', completed: false, userId: 1, isDeleted: false),
    TodoEntity(id: 2, todo: 'Test Todo 2', completed: true, userId: 1, isDeleted: false),
  ];

  group('FetchNextPageEvent', () {
    blocTest<TaskBloc, TaskState>(
      'emits [isFetchingMore: true, loaded with new data] when FetchNextPageEvent is added and use case returns data',
      build: () => taskBloc,
      act: (bloc) {
        bloc.add(FetchNextPageEvent());
      },
      expect: () => [
        const TaskState(isFetchingMore: true),
        TaskState(
          allTodoTasks: testTodos,
          isFetchingMore: false,
          allTodoStates: RequestState.loaded,
        ),
      ],
      // Provide the stubbed value directly here
      seed:()=> TaskState(allTodoTasks: testTodos),
    );

    blocTest<TaskBloc, TaskState>(
      'emits [isFetchingMore: true, isFetchingMore: false with error] when FetchNextPageEvent is added and use case returns an error',
      build: () => taskBloc,
      act: (bloc) {
        bloc.add(FetchNextPageEvent());
      },
      expect: () => [
        const TaskState(isFetchingMore: true),
        const TaskState(
          isFetchingMore: false,
          allTodoStates: RequestState.error,
          allTodoMessage: 'Error occurred',
        ),
      ],
      // Provide the stubbed value directly here
      seed:()=> const TaskState(allTodoStates: RequestState.error, allTodoMessage: 'Error occurred'),
    );
  });
}


