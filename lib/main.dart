import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc_observe.dart';
import 'package:todo_task/core/app_router/app_router.dart';
import 'package:todo_task/core/helper/cache_helper.dart';
import 'package:todo_task/core/network/dio.dart';
import 'package:todo_task/core/utilies/strings.dart';
import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  sl<DioHelper>();
  CacheHelper cacheHelper=CacheHelper();
  cacheHelper.clearToken();
  //Bloc.observer = Observe();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.todoName,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      routerConfig: route,
    );
  }
}
