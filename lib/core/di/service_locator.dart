import 'package:get_it/get_it.dart';
import 'package:todo_task/features/auth/data/data_source/remote_data/remote_data.dart';
import 'package:todo_task/features/auth/data/repository/login_repository_impl.dart';
import 'package:todo_task/features/auth/domain/repositories/base_login_repository.dart';
import 'package:todo_task/features/tasks/data/repository/all_todo_repository_imp.dart';
import 'package:todo_task/features/tasks/data/repository/own_todo_repository_imp.dart';
import 'package:todo_task/features/tasks/domain/repositories/base_alltodo_repository.dart';
import 'package:todo_task/features/tasks/domain/use_cases/alltodo_use_case.dart';
import 'package:todo_task/features/tasks/domain/use_cases/own_tasks_usecase.dart';
import '../../features/auth/domain/use_case/login_use_case.dart';
import '../../features/auth/presenation/controller/login_cubit/cubit/login_cubit.dart';
import '../../features/tasks/data/data_source/todo_remote_data.dart';
import '../../features/tasks/presenation/controller/cubit/task_bloc.dart';
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

  sl.registerLazySingleton<BaseAllTodoRepository>(() => AllTodoRepositoryImpl(
        allTodoRemoteDataSource: sl(),
      ));

  sl.registerLazySingleton<BaseOwnTodoRepository>(() => OwnTodoRepositoryImp(
        ownTodoRemoteDataSource: sl(),
      ));

  // Register UseCase
  sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(loginRepository: sl()));
  sl.registerLazySingleton<AllTodoUseCase>(
      () => AllTodoUseCase(allTodoRepository: sl()));

  sl.registerLazySingleton<OwnTasksUseCase>(
      () => OwnTasksUseCase(ownTodoRepository: sl()));

  // Register Cubit
  sl.registerFactory(() => LoginCubit(sl()));

  sl.registerFactory(() => TaskBloc(sl(), sl()));
}
