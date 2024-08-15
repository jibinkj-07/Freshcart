part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();
}

class CreateAccount extends AccountEvent {
  final String name;
  final String email;
  final String password;

  const CreateAccount({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

class SendVerificationMail extends AccountEvent {
  @override
  List<Object?> get props => [];
}

class ResetPassword extends AccountEvent {
  final String email;

  const ResetPassword({required this.email});

  @override
  List<Object?> get props => [email];
}
