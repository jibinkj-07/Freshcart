part of 'onboard_bloc.dart';

sealed class OnboardEvent extends Equatable {
  const OnboardEvent();
}

class AppStarted extends OnboardEvent {
  @override
  List<Object> get props => [];
}
