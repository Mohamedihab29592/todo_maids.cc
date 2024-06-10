import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_task/core/error/exceptions.dart';
import 'package:todo_task/features/tasks/data/data_source/todo_remote_data.dart';
import 'package:todo_task/features/tasks/data/model/todo_model.dart';
import 'package:todo_task/features/tasks/data/repository/all_todo_repository_imp.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';

class MockTodoRemoteDataSource extends Mock implements BaseTodoRemoteDataSource {}

void main() {
  late TodoRepositoryImpl repository;
  late MockTodoRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTodoRemoteDataSource();
    repository = TodoRepositoryImpl(todoRemoteDataSource: mockRemoteDataSource);
  });

  final testTodoModel = TodoModel(id: 1, todo: 'Test Todo', completed: false, userId: 1, isDeleted: false);
  final testTodoEntity = TodoEntity(id: 1, todo: 'Test Todo', completed: false, userId: 1, isDeleted: false);

  group('getAllTodo', () {
    test('should return Right(List<TodoEntity>) when call to remote data source is successful', () async {
      when(mockRemoteDataSource.getAllTodo(limit:10, skip:0))
          .thenAnswer((_) async => [testTodoModel]);

      final result = await repository.getAllTodo(limit: 10, skip: 0);

      expect(result, Right([testTodoEntity]));
      verify(mockRemoteDataSource.getAllTodo(limit: 10, skip: 0));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Left(ServerException) when call to remote data source fails', () async {
      when(mockRemoteDataSource.getAllTodo(limit: 10, skip:0))
          .thenThrow(ServerException("error"));

      final result = await repository.getAllTodo(limit: 10, skip: 0);

      expect(result.isLeft(), true);
      result.fold(
            (exception) => expect(exception, isA<ServerException>()),
            (_) => fail('Expected a ServerException'),
      );
    });
  });

  group('getOwnTodo', () {
    test('should return Right(List<TodoEntity>) when call to remote data source is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getOwnTodo(userId: 1))
          .thenAnswer((_) async => [testTodoModel]);

      final result = await repository.getOwnTodo(userId: 1);

      expect(result, Right([testTodoEntity]));
      verify(mockRemoteDataSource.getOwnTodo(userId: 1));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Left(ServerException) when call to remote data source fails', () async {
      when(mockRemoteDataSource.getOwnTodo(userId: 1))
          .thenThrow(ServerException("error"));

      final result = await repository.getOwnTodo(userId: 1);

      expect(result.isLeft(), true);
      result.fold(
            (exception) => expect(exception, isA<ServerException>()),
            (_) => fail('Expected a ServerException'),
      );
    });
  });

  group('addTodo', () {
    test('should return Right(TodoEntity) when call to remote data source is successful', () async {
      when(mockRemoteDataSource.addTodo(
        todo:"Todo message",
        completed: true,
        userId:1,
      )).thenAnswer((_) async => testTodoModel);

      final result = await repository.addTodo(
        todo: 'New Todo 1',
        completed: false,
        userId: 1,
      );

      expect(result, Right(testTodoEntity));
      verify(mockRemoteDataSource.addTodo(
        todo: 'New Todo 2 ',
        completed: false,
        userId: 1,
      ));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Left(ServerException) when call to remote data source fails', () async {
      when(mockRemoteDataSource.addTodo(
        todo:"new Todo 3",
        completed: false,
        userId: 1,
      )).thenThrow(ServerException("Error"));

      final result = await repository.addTodo(
        todo: 'New Todo',
        completed: false,
        userId: 1,
      );

      expect(result.isLeft(), true);
      result.fold(
            (exception) => expect(exception, isA<ServerException>()),
            (_) => fail('Expected a ServerException'),
      );
    });
  });

  group('deleteTodo', () {
    test('should return Right(TodoEntity) when call to remote data source is successful', () async {
      when(mockRemoteDataSource.deleteTodo(todoId: 1))
          .thenAnswer((_) async => testTodoModel);

      final result = await repository.deleteTodo(todoId: 1);

      expect(result, Right(testTodoEntity));
      verify(mockRemoteDataSource.deleteTodo(todoId: 1));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Left(ServerException) when call to remote data source fails', () async {
      when(mockRemoteDataSource.deleteTodo(todoId: 1))
          .thenThrow(ServerException("Error"));

      // Act
      final result = await repository.deleteTodo(todoId: 1);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
            (exception) => expect(exception, isA<ServerException>()),
            (_) => fail('Expected a ServerException'),
      );
    });
  });

  group('updateTodo', () {
    test('should return Right(TodoEntity) when call to remote data source is successful', () async {
      when(mockRemoteDataSource.updateTodo(
        todoId: 1,
        completed: false,
      )).thenAnswer((_) async => testTodoModel);

      final result = await repository.updateTodo(
        todoId: 1,
        completed: true,
      );

      expect(result, Right(testTodoEntity));
      verify(mockRemoteDataSource.updateTodo(
        todoId: 1,
        completed: true,
      ));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Left(ServerException) when call to remote data source fails', () async {
      when(mockRemoteDataSource.updateTodo(
        todoId: 1,
        completed: false,
      )).thenThrow(ServerException("error"));

      final result = await repository.updateTodo(
        todoId: 1,
        completed: true,
      );

      expect(result.isLeft(), true);
      result.fold(
            (exception) => expect(exception, isA<ServerException>()),
            (_) => fail('Expected a ServerException'),
      );
    });
  });
}
