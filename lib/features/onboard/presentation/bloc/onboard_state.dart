part of 'onboard_bloc.dart';

enum OnboardStatus {
  loading,
  onboarding,
  adminAccess,
  unknown,
}

class OnboardState extends Equatable {
  final OnboardStatus status;

  const OnboardState._({this.status = OnboardStatus.loading});

  const OnboardState.loading() : this._();

  const OnboardState.unknown() : this._(status: OnboardStatus.unknown);

  const OnboardState.onboarding() : this._(status: OnboardStatus.onboarding);

  const OnboardState.adminAccess() : this._(status: OnboardStatus.adminAccess);

  @override
  List<Object> get props => [];
}
