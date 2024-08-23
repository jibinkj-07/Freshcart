part of 'auth_bloc.dart';

enum EmailStatus { verified, notVerified }

enum AuthStatus { idle, loggingIn, signingOut }

class AuthState extends Equatable {
  final UserModel? userInfo;
  final EmailStatus emailStatus;
  final AuthStatus authStatus;
  final Failure? error;

  const AuthState._({
    this.emailStatus = EmailStatus.notVerified,
    this.authStatus = AuthStatus.idle,
    this.userInfo,
    this.error,
  });

  const AuthState.initial() : this._();

  const AuthState.error(Failure message) : this._(error: message);

  AuthState copyWith({
    EmailStatus? emailStatus,
    UserModel? userInfo,
    AuthStatus? authStatus,
    Failure? error,
  }) =>
      AuthState._(
        emailStatus: emailStatus ?? this.emailStatus,
        userInfo: userInfo ?? this.userInfo,
        authStatus: authStatus ?? this.authStatus,
        error: error,
      );

  @override
  List<Object?> get props => [
        userInfo,
        emailStatus,
        authStatus,
        error,
      ];
}
