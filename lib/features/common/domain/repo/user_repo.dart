import 'dart:io';
import 'package:either_dart/either.dart';
import '../../../../core/util/error/failure.dart';
import '../../data/model/user_model.dart';

abstract class UserRepo {
  Future<Either<Failure, UserModel>> getUserDetail({
    required String uid,
    required bool fromRemote,
  });

  Future<bool> userAuthenticated();

  Future<Either<Failure, UserModel>> createAccount({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, UserModel>> loginUser({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> resetPassword({required String email});

  Future<Either<Failure, String>> updateProfilePicture({
    required String uid,
    required File image,
  });

  Future<bool> checkEmailVerified();

  Future<Either<Failure, bool>> sendVerificationMail();

  Future<Either<Failure, void>> signOut();
}
