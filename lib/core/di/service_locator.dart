

import 'package:get_it/get_it.dart';
import 'package:todo_task/features/auth/data/data_source/remote_data/remote_data.dart';
import 'package:todo_task/features/auth/data/repository/login_repository_impl.dart';
import 'package:todo_task/features/auth/domain/repositories/base_login_repository.dart';

import '../../features/auth/domain/use_case/login_use_case.dart';
import '../../features/auth/presenation/controller/login_cubit/cubit/login_cubit.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Register RemoteDataSource
  sl.registerLazySingleton<BaseLoginRemoteDataSource>(
          () => LoginRemoteDataSource());

  // Register UserRepository
  sl.registerLazySingleton<BaseLoginRepository>(() => LoginRepositoryImpl(
    loginRemoteDataSource: sl(),
  ));

  // Register LoginUseCase
  sl.registerLazySingleton<LoginUseCase>(
          () => LoginUseCase(loginRepository: sl()));

  // Register LoginCubit
  sl.registerFactory(() => LoginCubit(sl()));

}

