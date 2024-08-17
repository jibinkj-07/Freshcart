part of 'account_bloc.dart';

enum AccountStatus {
  idle,
  creatingAccount,
  accountCreated,
  sendingVerificationMail,
  emailVerified,
  sendingResetInstruction,
  resetInstructionSent,
}

class AccountState extends Equatable {
  final AccountStatus status;
  final Failure? error;

  const AccountState({
    this.status = AccountStatus.idle,
    this.error,
  });

  const AccountState.initial() : this();

  const AccountState.error(Failure message) : this(error: message);

  AccountState copyWith({AccountStatus? status, Failure? error}) =>
      AccountState(
        status: status ?? this.status,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [status, error];
}
