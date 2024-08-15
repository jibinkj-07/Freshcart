import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/util/error/failure.dart';
import '../../data/model/user_model.dart';
import '../../domain/repo/user_repo.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo _userRepo;
  final FirebaseAuth _firebaseAuth;

  UserBloc(
    this._userRepo,
    this._firebaseAuth,
  ) : super(const UserState.fetching()) {
    on<UserEvent>(
      (event, emit) async {
        switch (event) {
          case CheckUserAuthentication():
            await _checkUserAuthentication(event, emit);
            break;
          case CheckUserEmailVerification():
            await _checkUserEmailVerification(event, emit);
            break;
          case GetUserDetail():
            await _getUserDetail(event, emit);
            break;
          case ConfigureUser():
            await _configureUser(event, emit);
            break;
          case LoginUser():
            await _loginUser(event, emit);
            break;
          case CreateAccount():
            await _createAccount(event, emit);
            break;
          case SendVerificationMail():
            await _sendVerificationMail(event, emit);
            break;
          case ResetPassword():
            await _resetPassword(event, emit);
            break;
          case UpdateProfilePicture():
            await _updateProfilePicture(event, emit);
            break;
          case SignOut():
            await _signOut(event, emit);
            break;
        }
      },
    );
  }

  Future<void> _loginUser(
    LoginUser event,
    Emitter<UserState> emit,
  ) async {
    // Emit fetching state
    emit(const UserState.unAuthenticated().copyWith(fetching: true));

    try {
      // Perform login
      final result = await _userRepo.loginUser(
        email: event.email,
        password: event.password,
      );
      if (result.isLeft) {
        emit(state.copyWith(error: result.left, fetching: false));
      } else {
        // Handle login success and check email verification
        final isVerified = await _userRepo.checkEmailVerified();
        emit(
          const UserState.authenticated().copyWith(
            userDetail: result.right,
            emailVerified: isVerified,
            error: null,
            fetching: false,
          ),
        );
      }
    } catch (e) {
      // Handle any other errors
      log("er: [_loginUser][user_bloc.dart] $e");
      emit(
        state.copyWith(
            fetching: false,
            error: Failure(message: 'An unexpected error occurred')),
      );
    }
  }

  Future<void> _createAccount(
    CreateAccount event,
    Emitter<UserState> emit,
  ) async {
    await _userRepo
        .createAccount(
      email: event.email,
      password: event.password,
      name: event.name,
    )
        .then(
      (result) async {
        if (result.isLeft) {
          emit(UserState.unAuthenticated()
              .copyWith(fetching: false, error: result.left));
        } else {
          emit(
            const UserState.authenticated().copyWith(
              userDetail: result.right,
              emailVerified: false,
              error: null,
            ),
          );
        }
      },
    );
  }

  Future<void> _checkUserAuthentication(
    CheckUserAuthentication event,
    Emitter<UserState> emit,
  ) async {
    if (await _userRepo.userAuthenticated()) {
      emit(const UserState.authenticated());
    } else {
      emit(const UserState.unAuthenticated());
    }
  }

  Future<void> _sendVerificationMail(
    SendVerificationMail event,
    Emitter<UserState> emit,
  ) async {
    await _userRepo.sendVerificationMail().then(
      (result) {
        if (result.isLeft) {
          emit(state.copyWith(error: result.left));
        } else {
          emit(state.copyWith(error: null));
        }
      },
    );
  }

  Future<void> _checkUserEmailVerification(
    CheckUserEmailVerification event,
    Emitter<UserState> emit,
  ) async {
    if (await _userRepo.checkEmailVerified()) {
      emit(state.copyWith(emailVerified: true));
    }
  }

  Future<void> _resetPassword(
    ResetPassword event,
    Emitter<UserState> emit,
  ) async {
    try {
      // Set fetching to true before starting the operation
      emit(state.copyWith(fetching: true));

      // Perform the reset password operation
      final result = await _userRepo.resetPassword(email: event.email);

      // Check the result and emit the corresponding state
      if (result.isLeft) {
        emit(state.copyWith(error: result.left, fetching: false));
      } else {
        emit(state.copyWith(error: null, fetching: false));
      }
    } catch (e) {
      // Log the error and emit an error state
      log("Error: [_resetPassword][user_bloc.dart] $e");
      emit(
        state.copyWith(
          fetching: false,
          error: Failure(message: 'An unexpected error occurred'),
        ),
      );
    }
  }

  Future<void> _updateProfilePicture(
    UpdateProfilePicture event,
    Emitter<UserState> emit,
  ) async {
    await _userRepo
        .updateProfilePicture(uid: event.userId, image: event.image)
        .then((result) {
      if (result.isLeft) {
        emit(state.copyWith(error: result.left));
      } else {
        final userDetail = state.userDetail!.copyWith(imageUrl: result.right);
        emit(state.copyWith(error: null, userDetail: userDetail));
      }
    });
  }

  Future<void> _getUserDetail(
    GetUserDetail event,
    Emitter<UserState> emit,
  ) async {
    _userRepo
        .getUserDetail(
      uid: _firebaseAuth.currentUser?.uid ?? "unknownUser",
      fromRemote: event.fromRemote,
    )
        .then((result) {
      if (result.isLeft) {
        emit(
          const UserState.unAuthenticated()
              .copyWith(fetching: false, error: result.left),
        );
      } else {
        emit(state.copyWith(userDetail: result.right, error: null));
      }
    });
  }

  Future<void> _configureUser(
    ConfigureUser event,
    Emitter<UserState> emit,
  ) async {
    try {
      // Checking if user is authenticated or not
      if (!await _userRepo.userAuthenticated()) {
        emit(const UserState.unAuthenticated());
        return;
      }

      // Checking if user email is verified or not
      if (!await _userRepo.checkEmailVerified()) {
        emit(const UserState.authenticated());
      }

      final uid = _firebaseAuth.currentUser!.uid;
      // Attempt to retrieve user details from cache first
      final cacheUser = await _userRepo.getUserDetail(
        uid: uid,
        fromRemote: false,
      );

      if (cacheUser.isRight) {
        emit(
          const UserState.authenticated().copyWith(
            emailVerified: true,
            userDetail: cacheUser.right,
            error: null,
            fetching: false,
          ),
        );
      }
      // Attempt to retrieve user details from remote
      final remoteUser = await _userRepo.getUserDetail(
        uid: uid,
        fromRemote: true,
      );
      if (remoteUser.isRight) {
        emit(
          const UserState.authenticated().copyWith(
            emailVerified: true,
            userDetail: remoteUser.right,
            error: null,
            fetching: false,
          ),
        );
      }
    } catch (e) {
      log("er[_configureUser][user_bloc.dart] $e");
      emit(
        const UserState.unAuthenticated().copyWith(
          fetching: false,
          error: Failure(message: "Something went wrong."),
        ),
      );
    }
  }

  Future<void> _signOut(
    SignOut event,
    Emitter<UserState> emit,
  ) async {
    await _userRepo.signOut().then(
      (result) {
        if (result.isLeft) {
          emit(state.copyWith(error: result.left));
        } else {
          emit(const UserState.unAuthenticated());
        }
      },
    );
  }

  @override
  void onEvent(UserEvent event) {
    super.onEvent(event);
    log("Event dispatched: $event");
  }
}
