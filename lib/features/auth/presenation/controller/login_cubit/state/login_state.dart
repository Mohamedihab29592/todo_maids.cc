

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates {


}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}



class SeePassState extends LoginStates{}


class ChangePasswordState extends LoginStates{

}
class LoadingPasswordState extends LoginStates{}
class ErrorPasswordState extends LoginStates{
  final String error;
  ErrorPasswordState(this.error);
}
