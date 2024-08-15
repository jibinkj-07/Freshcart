part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {}

class CheckUserAuthentication extends UserEvent {
  @override
  List<Object?> get props => [];
}

class LoginUser extends UserEvent {
  final String email;
  final String password;

  LoginUser({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class CreateAccount extends UserEvent {
  final String email;
  final String name;
  final String password;

  CreateAccount({
    required this.email,
    required this.name,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

class CheckUserEmailVerification extends UserEvent {
  @override
  List<Object?> get props => [];
}

class SendVerificationMail extends UserEvent {
  @override
  List<Object?> get props => [];
}

class ResetPassword extends UserEvent {
  final String email;

  ResetPassword({required this.email});

  @override
  List<Object?> get props => [email];
}

class UpdateProfilePicture extends UserEvent {
  final String userId;
  final File image;

  UpdateProfilePicture({
    required this.userId,
    required this.image,
  });

  @override
  List<Object?> get props => [userId, image];
}

class SignOut extends UserEvent {
  @override
  List<Object?> get props => [];
}

class GetUserDetail extends UserEvent {
  final bool fromRemote;

  GetUserDetail({
    required this.fromRemote,
  });

  @override
  List<Object?> get props => [fromRemote];
}

class ConfigureUser extends UserEvent {
  @override
  List<Object?> get props => [];
}
