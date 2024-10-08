import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/util/error/failure.dart';
import '../../../onboard/presentation/bloc/onboard_bloc.dart';
import '../../data/model/user_model.dart';
import '../../domain/repo/user_repo.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepo _userRepo;
  final OnboardBloc _onboardBloc;
  final FirebaseAuth _firebaseAuth;

  AuthBloc(this._userRepo, this._firebaseAuth, this._onboardBloc)
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
          case AddUser():
            _addUser(event, emit);
            break;
          case UpdateEmailStatus():
            _updateEmailStatus(event, emit);
            break;
        }
      },
    );
  }

  // Events
  void _addUser(AddUser event, Emitter<AuthState> emit) {
    emit(
      const AuthState.initial().copyWith(
        userInfo: event.user,
        emailStatus: event.emailStatus,
      ),
    );
  }

  Future<void> _initUser(InitUser event, Emitter<AuthState> emit) async {
    try {
      // Checking if user is authenticated or not
      if (!await _userRepo.userAuthenticated()) {
        // Let be know onboard bloc to update its status
        _onboardBloc.add(
          const UpdateStatus(onboardStatus: OnboardStatus.onboard),
        );
        return;
      }

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
            error: null,
            authStatus: AuthStatus.idle,
          ),
        );
        // Let be know onboard bloc to update its status
        _onboardBloc.add(
          const UpdateStatus(onboardStatus: OnboardStatus.onboarded),
        );
      }

      // Checking if user email is verified or not
      final emailStatus = await _userRepo.checkEmailVerified()
          ? EmailStatus.verified
          : EmailStatus.notVerified;
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
        // Let be know onboard bloc to update its status
        _onboardBloc.add(
          const UpdateStatus(onboardStatus: OnboardStatus.onboarded),
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
        emit(AuthState.error(result.left));
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

  void _updateEmailStatus(UpdateEmailStatus event, Emitter<AuthState> emit) {
    emit(state.copyWith(emailStatus: event.emailStatus));
  }

  Future<void> _signOut(SignOut event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.signingOut));
    try {
      final result = await _userRepo.signOut();
      if (result.isLeft) {
        emit(state.copyWith(error: result.left, authStatus: AuthStatus.idle));
      } else {
        _onboardBloc.add(
          const UpdateStatus(onboardStatus: OnboardStatus.onboard),
        );
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
    log("AuthEvent dispatched: $event");
  }
}
