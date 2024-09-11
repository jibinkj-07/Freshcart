part of 'onboard_bloc.dart';

sealed class OnboardEvent extends Equatable {
  const OnboardEvent();
}

class AppStarted extends OnboardEvent {
  @override
  List<Object> get props => [];
}

class UpdateStatus extends OnboardEvent {
  final OnboardStatus onboardStatus;

  const UpdateStatus({required this.onboardStatus});

  @override
  List<Object> get props => [onboardStatus];
}
