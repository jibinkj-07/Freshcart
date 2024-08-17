import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:either_dart/either.dart';
import '../../../../core/config/firebase/path_mapper.dart';
import '../../../../core/util/error/failure.dart';
import '../model/user_model.dart';

abstract class UserFbDataSource {
  Future<Either<Failure, UserModel>> getUserDetail({required String uid});

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

  Future<bool> checkEmailVerified(bool hasInternet);

  Future<Either<Failure, bool>> sendVerificationMail();

  Future<Either<Failure, void>> signOut();
}

class UserFbDataSourceImpl implements UserFbDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseDatabase _firebaseDatabase;
  final FirebaseStorage _firebaseStorage;

  UserFbDataSourceImpl(
    this._firebaseAuth,
    this._firebaseDatabase,
    this._firebaseStorage,
  );

  @override
  Future<Either<Failure, UserModel>> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Creating new user into firebase auth
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(name);
      final uid = userCredential.user?.uid ?? "unknownUser";
      final user = UserModel(
        uid: uid,
        name: name,
        email: email,
        imageUrl: "",
        createdOn: userCredential.user?.metadata.creationTime ?? DateTime.now(),
        favourites: [],
        isAdmin: false,
        address: [],
      );

      // Storing new user details into firebase db
      await _firebaseDatabase
          .ref(PathMapper.userPath(uid))
          .set(user.toFirebaseJson());

      // returning user data back to function call
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message.toString()));
    } catch (e) {
      log("er:[createAccount][user_fb_data_source.dart] $e");
      return Left(Failure(message: "Something went wrong. Try again"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // Creating new user into firebase auth
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid ?? "unknownUser";

      // Retrieving and returning user details from firebase db
      return await getUserDetail(uid: uid);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message.toString()));
    } catch (e) {
      log("er:[loginUser][user_fb_data_source.dart] $e");
      return Left(Failure(message: "Something went wrong. Try again"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserDetail(
      {required String uid}) async {
    try {
      // Retrieving  user details from firebase db
      final userSnapshot =
          await _firebaseDatabase.ref(PathMapper.userPath(uid)).get();
      final user = UserModel.fromFirebase(userSnapshot, uid);
      // returning user data back to function call
      return Right(user);
    } catch (e) {
      log("er:[getUserDetail][user_fb_data_source.dart] $e");
      return Left(Failure(message: "Something went wrong. Try again"));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfilePicture({
    required String uid,
    required File image,
  }) async {
    String url = "";
    try {
      final reference = _firebaseStorage.ref("Profile Pictures/$uid.jpg");
      await reference.putFile(image);
      url = await reference.getDownloadURL();
      await _firebaseAuth.currentUser!.updatePhotoURL(url);
      await FirebaseDatabase.instance
          .ref(PathMapper.userInfoPath(uid))
          .update({'image_url': url});
      return Right(url);
    } catch (e) {
      log("er:[updateProfilePicture][user_fb_data_source.dart] $e");
      return Left(Failure(message: "Unable to upload image. Try again"));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      log("er:[signOut][user_fb_data_source.dart] $e");
      return Left(Failure(message: "Something went wrong. Try again"));
    }
  }

  @override
  Future<bool> checkEmailVerified(bool hasInternet) async {
    try {
      if (hasInternet) await _firebaseAuth.currentUser!.reload();
      return _firebaseAuth.currentUser!.emailVerified;
    } catch (e) {
      log("er:[checkEmailVerified][user_fb_data_source.dart] $e");
      return false;
    }
  }

  @override
  Future<Either<Failure, bool>> sendVerificationMail() async {
    try {
      await _firebaseAuth.currentUser!.sendEmailVerification();
      return const Right(true);
    } catch (e) {
      log("er:[sendVerificationMail][user_fb_data_source.dart] $e");
      return Left(Failure(message: "Something went wrong. Try again"));
    }
  }

  @override
  Future<bool> userAuthenticated() async {
    try {
      await _firebaseAuth.currentUser!.reload();
    } catch (e) {
      log("er:[userAuthenticated][user_fb_data_source.dart] $e");
    }
    return _firebaseAuth.currentUser != null;
  }
}
