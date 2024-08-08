part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {}

class CheckUserAuthentication extends UserEvent {
  @override
  List<Object?> get props => [];
}

class CheckUserEmailVerification extends UserEvent {
  @override
  List<Object?> get props => [];
}

class GetUserDetail extends UserEvent {
  final bool fromRemote;
  final BuildContext context;

   GetUserDetail({
    required this.fromRemote,
    required this.context,
  });

  @override
  List<Object?> get props => [fromRemote];
}

class ConfigureUser extends UserEvent {
  @override
  List<Object?> get props => [];
}
