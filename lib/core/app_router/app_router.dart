import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_task/core/helper/cache_helper.dart';
import 'package:todo_task/features/tasks/presenation/controller/bloc/task_manager/manager_cubit.dart';
import '../../features/splash_screen.dart';
import '../../features/tasks/presenation/controller/bloc/task/task_bloc.dart';
import '../../features/tasks/presenation/controller/bloc/task/task_event.dart';
import '../../features/tasks/presenation/screens/add_screen.dart';
import '../di/service_locator.dart';

import '../../features/auth/presenation/controller/login_cubit/cubit/login_cubit.dart';
import '../../features/auth/presenation/screens/login.dart';
import '../../features/tasks/presenation/screens/layout.dart';
import '../helper/user_id.dart';

class AppRouter {
  static const String kMain = '/';
  static const String kLogin = '/login';
  static const String kLayout = '/layout';
  static const String kAdd = '/add';
}

final cacheHelper = sl<CacheHelper>();
final route = GoRouter(
  initialLocation: AppRouter.kMain,
  errorPageBuilder: (context, state) =>
      const MaterialPage(child: Scaffold(body: Text('Not Found'))),
  routes: [
    GoRoute(
      path: AppRouter.kMain,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
        path: AppRouter.kLogin,
        builder: (context, state) => BlocProvider(
              create: (context) => sl<LoginCubit>(),
              child: const LoginScreen(),
            )),
    GoRoute(
      path: AppRouter.kLayout,
      builder: (context, state) {
        return BlocBuilder<UserBloc, int?>(
          builder: (context, userId) {
            if (userId == null) {
              return const CircularProgressIndicator.adaptive();
            }

            return BlocProvider(
              create: (context) => sl<TaskBloc>()
                ..add(FetchAllTasksEvent())
                ..add(FetchOwnTasksEvent(userId: userId)),
              child: const LayoutScreen(),
            );
          },
        );
      },
    ),
    GoRoute(
      path: AppRouter.kAdd,
      builder: (context, state) {
        return BlocBuilder<UserBloc, int?>(
          builder: (context, userId) {
            if (userId == null) {
              return const CircularProgressIndicator.adaptive();
            }

            return BlocProvider(
              create: (context) => sl<ManagerCubit>(),
              child: AddScreen(userId: userId),
            );
          },
        );
      },
    ),

  ],
);
