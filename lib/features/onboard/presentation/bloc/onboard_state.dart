part of 'onboard_bloc.dart';

enum OnboardStatus {
  unknown,
  onboarding,
  adminAccess,
}

class OnboardState extends Equatable {
  final OnboardStatus status;

  const OnboardState._({this.status = OnboardStatus.unknown});

  const OnboardState.unknown() : this._();

  const OnboardState.onboarding() : this._(status: OnboardStatus.onboarding);

  const OnboardState.adminAccess() : this._(status: OnboardStatus.adminAccess);

  @override
  List<Object> get props => [];
}
