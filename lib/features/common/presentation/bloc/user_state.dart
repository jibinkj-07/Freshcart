part of 'user_bloc.dart';

enum UserStatus { fetching, authenticated, unauthenticated }

class UserState extends Equatable {
  final UserStatus status;
  final UserModel? userDetail;
  final bool emailVerified;
  final Failure? error;
  final bool fetching;

  const UserState._({
    this.status = UserStatus.fetching,
    this.emailVerified = false,
    this.userDetail,
    this.error,
    this.fetching = false,
  });

  const UserState.fetching() : this._();

  const UserState.authenticated() : this._(status: UserStatus.authenticated);

  const UserState.unAuthenticated()
      : this._(status: UserStatus.unauthenticated);

  UserState copyWith({
    UserStatus? status,
    UserModel? userDetail,
    bool? emailVerified,
    Failure? error,
    bool? fetching,
  }) {
    return UserState._(
      status: status ?? this.status,
      userDetail: userDetail ?? this.userDetail,
      emailVerified: emailVerified ?? this.emailVerified,
      error: error,
      fetching: fetching ?? this.fetching,
    );
  }

  @override
  String toString() =>
      "status : $status\nEmail Verified: $emailVerified\nUser : $userDetail";

  @override
  List<Object?> get props => [
        status,
        userDetail,
        emailVerified,
        error,
        fetching,
      ];
}
