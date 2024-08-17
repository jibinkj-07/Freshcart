part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class AddUser extends AuthEvent {
  final UserModel user;
  final EmailStatus emailStatus;

  const AddUser({
    required this.user,
    required this.emailStatus,
  });

  @override
  List<Object?> get props => [user];
}

class UpdateEmailStatus extends AuthEvent {
  final EmailStatus emailStatus;

  const UpdateEmailStatus({
    required this.emailStatus,
  });

  @override
  List<Object?> get props => [emailStatus];
}

class InitUser extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LoginUser extends AuthEvent {
  final String email;
  final String password;

  const LoginUser({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SignOut extends AuthEvent {
  @override
  List<Object?> get props => [];
}
