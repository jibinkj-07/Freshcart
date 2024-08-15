part of 'account_bloc.dart';

enum AccountStatus {
  idle,
  creatingAccount,
  sendingVerificationMail,
  sendingResetInstruction,
  resetInstructionSent,
}

class AccountState extends Equatable {
  final AccountStatus status;
  final Failure? error;

  const AccountState._({
    this.status = AccountStatus.idle,
    this.error,
  });

  const AccountState.initial() : this._();

  const AccountState.error(Failure message) : this._(error: message);

  AccountState copyWith({AccountStatus? status, Failure? error}) =>
      AccountState._(
        status: status ?? this.status,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [status, error];
}
