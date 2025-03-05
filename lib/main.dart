import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/core/app_router/app_router.dart';
import 'package:todo_task/core/network/dio.dart';
import 'package:todo_task/core/utilies/strings.dart';
import 'core/di/service_locator.dart';
import 'core/helper/cache_helper.dart';
import 'core/helper/user_id.dart';
import 'observe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  sl<DioHelper>();
  Bloc.observer = Observe();
  runApp(const MyApp());
}
//update
//update
//task1done
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(sl<CacheHelper>()),
        ),

      ],
      child: MaterialApp.router(
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
      ),
    );
  }
}
