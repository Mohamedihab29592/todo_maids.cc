import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/use_case/login_use_case.dart';
import '../state/login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginInitialState());

  static LoginCubit of(BuildContext context) =>
      BlocProvider.of<LoginCubit>(context);

  Future<void> userLogin({
    required String userName,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoadingState());
    final userLoginEntity = UserLoginEntity(userName: userName, password: password);
    final result = await _loginUseCase(userLoginEntity);
    result.fold(
          (failure) {
        emit(LoginErrorState("user Login faild"));
      },
          (_) {
        emit(LoginSuccessState());
      },
    );
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordVisible = true;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    suffix =
    isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SeePassState());
  }



}
