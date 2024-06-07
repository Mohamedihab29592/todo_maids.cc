import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash_screen.dart';
import '../di/service_locator.dart' as di;

import '../../features/auth/presenation/controller/login_cubit/cubit/login_cubit.dart';
import '../../features/auth/presenation/screens/login.dart';
import '../../features/tasks/presenation/screens/layout.dart';

class AppRouter {
  static const String kMain = '/';
  static const String kLogin = '/login';
  static const String kLayout = '/layout';


}

 final route = GoRouter(
  initialLocation: AppRouter.kMain,
  errorPageBuilder: (context, state) => const MaterialPage(child: Scaffold(body: Text('Not Found'))),
  routes: [
    GoRoute(
      path: AppRouter.kMain,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
        path: AppRouter.kLogin,
        builder: (context, state) => BlocProvider(
          create: (context) => di.sl<LoginCubit>(),
          child: const LoginScreen(),
        )),

    GoRoute(
      path: AppRouter.kLayout,
      builder: (context, state) => const LayoutScreen(),
    ),
  ],
);