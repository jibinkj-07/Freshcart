import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/util/error/failure.dart';
import '../../data/model/user_model.dart';
import '../../domain/repo/user_repo.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepo _userRepo;
  final FirebaseAuth _firebaseAuth;

  AuthBloc(this._userRepo, this._firebaseAuth)
      : super(const AuthState.initial()) {
    on<AuthEvent>(
      (event, emit) async {
        switch (event) {
          case InitUser():
            await _initUser(event, emit);
            break;
          case LoginUser():
            await _loginUser(event, emit);
            break;
          case SignOut():
            await _signOut(event, emit);
            break;
        }
      },
    );
  }

  // Events
  Future<void> _initUser(InitUser event, Emitter<AuthState> emit) async {
    try {
      // Checking if user is authenticated or not
      if (!await _userRepo.userAuthenticated()) return;

      // Checking if user email is verified or not
      final emailStatus = await _userRepo.checkEmailVerified()
          ? EmailStatus.verified
          : EmailStatus.notVerified;

      final uid = _firebaseAuth.currentUser!.uid;
      // Attempt to retrieve user details from cache first
      final cacheUser = await _userRepo.getUserDetail(
        uid: uid,
        fromRemote: false,
      );

      if (cacheUser.isRight) {
        emit(
          state.copyWith(
            userInfo: cacheUser.right,
            emailStatus: emailStatus,
            error: null,
            authStatus: AuthStatus.idle,
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
          state.copyWith(
            userInfo: remoteUser.right,
            emailStatus: emailStatus,
            error: null,
            authStatus: AuthStatus.idle,
          ),
        );
      }
    } catch (e) {
      log("er: [_initUser][auth_bloc.dart] $e");
      emit(
        AuthState.error(
          Failure(message: "An unexpected error occurred"),
        ),
      );
    }
  }

  Future<void> _loginUser(LoginUser event, Emitter<AuthState> emit) async {
    // Emit fetching state
    emit(const AuthState.initial().copyWith(authStatus: AuthStatus.loggingIn));
    try {
      // Perform login
      final result = await _userRepo.loginUser(
        email: event.email,
        password: event.password,
      );
      if (result.isLeft) {
        emit(state.copyWith(
          error: result.left,
          authStatus: AuthStatus.idle,
        ));
      } else {
        // Checking if user email is verified or not
        final emailStatus = await _userRepo.checkEmailVerified()
            ? EmailStatus.verified
            : EmailStatus.notVerified;
        emit(
          state.copyWith(
            userInfo: result.right,
            emailStatus: emailStatus,
            error: null,
            authStatus: AuthStatus.idle,
          ),
        );
      }
    } catch (e) {
      // Handle any other errors
      log("er: [_loginUser][auth_bloc.dart] $e");
      emit(
        AuthState.error(
          Failure(message: "An unexpected error occurred"),
        ),
      );
    }
  }

  Future<void> _signOut(SignOut event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.signingOut));
    try {
      final result = await _userRepo.signOut();
      if (result.isLeft) {
        emit(state.copyWith(error: result.left, authStatus: AuthStatus.idle));
      } else {
        emit(const AuthState.initial());
      }
    } catch (e) {
      // Handle any other errors
      log("er: [_signOut][auth_bloc.dart] $e");
      emit(
        AuthState.error(
          Failure(message: "An unexpected error occurred"),
        ),
      );
    }
  }

  @override
  void onEvent(AuthEvent event) {
    super.onEvent(event);
    log("Event dispatched: $event");
  }
}
