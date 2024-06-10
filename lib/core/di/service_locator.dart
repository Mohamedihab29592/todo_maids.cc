import 'package:get_it/get_it.dart';
import 'package:todo_task/features/auth/data/data_source/remote_data/remote_data.dart';
import 'package:todo_task/features/auth/data/repository/login_repository_impl.dart';
import 'package:todo_task/features/auth/domain/repositories/base_login_repository.dart';
import 'package:todo_task/features/tasks/data/repository/all_todo_repository_imp.dart';
import 'package:todo_task/features/tasks/domain/repositories/base_alltodo_repository.dart';
import 'package:todo_task/features/tasks/domain/use_cases/add_tasks_usecase.dart';
import 'package:todo_task/features/tasks/domain/use_cases/alltodo_use_case.dart';
import 'package:todo_task/features/tasks/domain/use_cases/delete_tasks_usecase.dart';
import 'package:todo_task/features/tasks/domain/use_cases/own_tasks_usecase.dart';
import 'package:todo_task/features/tasks/domain/use_cases/update_tasks_usecase.dart';
import 'package:todo_task/features/tasks/presenation/controller/bloc/task_manager/manager_cubit.dart';
import '../../features/auth/domain/use_case/login_use_case.dart';
import '../../features/auth/presenation/controller/login_cubit/cubit/login_cubit.dart';
import '../../features/tasks/data/data_source/todo_remote_data.dart';
import '../../features/tasks/presenation/controller/bloc/task/task_bloc.dart';
import '../helper/cache_helper.dart';
import '../network/dio.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Register DioHelper
  sl.registerLazySingleton<DioHelper>(() => DioHelper());
// Register CacheHelper
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper());

  // Register RemoteDataSource
  sl.registerLazySingleton<BaseLoginRemoteDataSource>(
      () => LoginRemoteDataSource());
  sl.registerLazySingleton<BaseTodoRemoteDataSource>(() => TodoDataSource());

  // Register Repository
  sl.registerLazySingleton<BaseLoginRepository>(() => LoginRepositoryImpl(
        loginRemoteDataSource: sl(),
      ));

  sl.registerLazySingleton<BaseTodoRepository>(() => TodoRepositoryImpl(
        todoRemoteDataSource: sl(),
      ));



  // Register UseCase
  sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(loginRepository: sl()));
  sl.registerLazySingleton<AllTodoUseCase>(
      () => AllTodoUseCase(allTodoRepository: sl()));

  sl.registerLazySingleton<OwnTasksUseCase>(
      () => OwnTasksUseCase(ownTodoRepository: sl()));

  sl.registerLazySingleton<AddTodoUseCase>(
          () => AddTodoUseCase(addTodoTasksRepo: sl()));

  sl.registerLazySingleton<DeleteTodoUseCase>(
          () => DeleteTodoUseCase(deleteTodoTasksRepo: sl()));


  sl.registerLazySingleton<UpdateTodoUseCase>(
          () => UpdateTodoUseCase(updateTodoTasksRepo: sl()));


  // Register Cubit
  sl.registerFactory(() => LoginCubit(sl()));

  sl.registerFactory(() => TaskBloc(sl(), sl()));
  sl.registerFactory(() => ManagerCubit(sl(), sl(),sl()));
}
