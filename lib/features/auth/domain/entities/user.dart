import 'package:equatable/equatable.dart';

class UserLoginEntity extends Equatable {
  final String userName;
  final String password;

  const UserLoginEntity({
    required this.userName,
    required this.password,
  });

  @override
  List<Object> get props => [userName, password];
}