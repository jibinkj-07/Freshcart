part of 'user_config_bloc.dart';

@immutable
sealed class UserConfigEvent {}

class GetIsNewUser extends UserConfigEvent {}

class GetIsAuthenticated extends UserConfigEvent {}

class GetIsAdmin extends UserConfigEvent {}

class SetIsNewUser extends UserConfigEvent {
  final bool isNew;

  SetIsNewUser({required this.isNew});
}

class SetIsAuthenticated extends UserConfigEvent {
  final bool isAuth;

  SetIsAuthenticated({required this.isAuth});
}

class SetIsAdmin extends UserConfigEvent {
  final bool isAdmin;

  SetIsAdmin({required this.isAdmin});
}
