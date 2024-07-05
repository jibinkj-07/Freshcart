part of 'onboard_bloc.dart';

sealed class OnboardEvent extends Equatable {
  const OnboardEvent();
}

class AppStarted extends OnboardEvent {
  @override
  List<Object> get props => [];
}

class SetIsNewUser extends OnboardEvent {
  final bool isNew;

  const SetIsNewUser({required this.isNew});

  @override
  List<Object> get props => [];
}

class SetIsAdmin extends OnboardEvent {
  final bool isAdmin;

  const SetIsAdmin({required this.isAdmin});

  @override
  List<Object> get props => [];
}
