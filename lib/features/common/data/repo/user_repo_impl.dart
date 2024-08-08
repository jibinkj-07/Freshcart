import 'dart:io';
import 'package:either_dart/either.dart';
import '../../../../core/util/error/failure.dart';
import '../../domain/repo/user_repo.dart';
import '../data_source/user_cache_data_source.dart';
import '../data_source/user_fb_data_source.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../model/user_model.dart';

class UserRepoImpl implements UserRepo {
  final UserFbDataSource _userFbDataSource;
  final UserCacheDataSource _userCacheDataSource;

  UserRepoImpl(
    this._userFbDataSource,
    this._userCacheDataSource,
  );

  @override
  Future<bool> checkEmailVerified() async =>
      await _userFbDataSource.checkEmailVerified(
        await InternetConnection().hasInternetAccess,
      );

  @override
  Future<Either<Failure, UserModel>> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    if (await InternetConnection().hasInternetAccess) {
      final result = await _userFbDataSource.createAccount(
        email: email,
        password: password,
        name: name,
      );
      // Storing user detail into local db
      if (result is Right) {
        await _userCacheDataSource.storeUser(user: result.right);
      }
      return result;
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserDetail({
    required String uid,
    required bool fromRemote,
  }) async {
    if (fromRemote) {
      if (await InternetConnection().hasInternetAccess) {
        final result = await _userFbDataSource.getUserDetail(uid: uid);
        // Storing user detail into local db
        if (result is Right) {
          await _userCacheDataSource.storeUser(user: result.right);
        }
        return result;
      } else {
        return Left(Failure(message: "Check your internet connection"));
      }
    } else {
      final user = await _userCacheDataSource.getUser();
      if (user == null) {
        return Left(Failure(message: "No data available. Try again"));
      }
      return Right(user);
    }
  }

  @override
  Future<Either<Failure, UserModel>> loginUser({
    required String email,
    required String password,
  }) async {
    if (await InternetConnection().hasInternetAccess) {
      final result = await _userFbDataSource.loginUser(
        email: email,
        password: password,
      );
      // Storing user detail into local db
      if (result is Right) {
        await _userCacheDataSource.storeUser(user: result.right);
      }
      return result;
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    if (await InternetConnection().hasInternetAccess) {
      final result = await _userFbDataSource.resetPassword(email: email);
      return result;
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, bool>> sendVerificationMail() async {
    if (await InternetConnection().hasInternetAccess) {
      return await _userFbDataSource.sendVerificationMail();
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    if (await InternetConnection().hasInternetAccess) {
      final result = await _userFbDataSource.signOut();
      if (result is Right) {
        await _userCacheDataSource.clearData();
      }
      return result;
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfilePicture({
    required String uid,
    required File image,
  }) async {
    if (await InternetConnection().hasInternetAccess) {
      final result = await _userFbDataSource.updateProfilePicture(
        uid: uid,
        image: image,
      );
      // Storing updated user detail into local db
      if (result is Right) {
        await _userCacheDataSource.updatePicture(url: result.right);
      }
      return result;
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }

  @override
  Future<bool> userAuthenticated() async =>
      await _userFbDataSource.userAuthenticated();
}
