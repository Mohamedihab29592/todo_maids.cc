import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/core/utilies/assets.dart';
import 'package:todo_task/core/utilies/strings.dart';
import '../../../../core/app_router/app_router.dart';
import '../../../../core/components/dialog.dart';
import '../controller/login_cubit/cubit/login_cubit.dart';
import '../controller/login_cubit/state/login_state.dart';
import '../../../../core/components/button.dart';
import '../widgets/form_field.dart';
import '../widgets/loading_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: SafeArea(
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              GoRouter.of(context).go(AppRouter.kLayout);
            } else if (state is LoginErrorState) {
              showDialog(
                context: context,
                builder: (context) {
                  return ShowDialogError(title:AppStrings.loginError, subTitle: state.error,  );
                },
              );            }
          },
          builder: (context, state) {
            return LoadingManager(
              color: Colors.white,
              isLoading: state is LoginLoadingState,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppStrings.login,
                            style: GoogleFonts.actor(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Image.asset(
                            AppAssets.logo,
                            height: 150,
                          ),
                          const SizedBox(height: 15),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                MyFormField(
                                  textCapitalization: TextCapitalization.none,
                                  maxLines: 1,
                                  controller: _usernameController,
                                  type: TextInputType.text,
                                  hint: AppStrings.userName,
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  validation: (value) {
                                    if (value.isEmpty) {
                                      return AppStrings.userNameValidate;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyFormField(
                                  maxLines: 1,
                                  textCapitalization: TextCapitalization.none,
                                  suffixIcon: LoginCubit.of(context).suffix,
                                  isPassword:
                                      LoginCubit.of(context).isPasswordVisible,
                                  suffixIconPressed: () {
                                    LoginCubit.of(context)
                                        .togglePasswordVisibility();
                                  },
                                  controller: _passwordController,
                                  type: TextInputType.text,
                                  hint: AppStrings.password,
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  validation: (value) {
                                    if (value.isEmpty) {
                                      return AppStrings.passwordValidate;
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            height: 50.0,
                            width: double.infinity,
                            child: PublicButton(
                              backgroundColor: Colors.white,
                              textColor: Colors.blue,
                              function: () async {
                                if (_formKey.currentState!.validate()) {
                                  await LoginCubit.of(context).userLogin(
                                    userName: _usernameController.text,
                                    password: _passwordController.text,
                                    context: context,
                                  );
                                }
                              },
                              text: 'Login',
                            ),
                          ),
                          const SizedBox(height: 60),
                          Text(
                            AppStrings.todoName,
                            style: GoogleFonts.actor(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
