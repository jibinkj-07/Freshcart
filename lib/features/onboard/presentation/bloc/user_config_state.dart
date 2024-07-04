part of 'user_config_bloc.dart';

@immutable
 class UserConfigState {
  final bool isNewUser;
  final bool isAdmin;
  final bool isAuthenticated;

  const UserConfigState({
    required this.isNewUser,
    required this.isAdmin,
    required this.isAuthenticated,
  });
}

final class UserConfigInitial extends UserConfigState {
  const UserConfigInitial()
      : super(
          isNewUser: true,
          isAdmin: false,
          isAuthenticated: false,
        );
}
