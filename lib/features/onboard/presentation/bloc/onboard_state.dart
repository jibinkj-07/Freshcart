part of 'onboard_bloc.dart';

enum OnboardStatus {
  loading,
  onboard,
  onboarded,
}

class OnboardState extends Equatable {
  final OnboardStatus status;

  const OnboardState._({this.status = OnboardStatus.loading});

  const OnboardState.loading() : this._();

  const OnboardState.onboard() : this._(status: OnboardStatus.onboard);

  const OnboardState.onboarded() : this._(status: OnboardStatus.onboarded);

  @override
  List<Object> get props => [status];
}
