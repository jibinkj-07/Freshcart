import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

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
    log("user bloc created");
    on<CheckUserAuthentication>(_checkUserAuthentication);
    on<CheckUserEmailVerification>(_checkUserEmailVerification);
    on<GetUserDetail>(_getUserDetail);
    on<ConfigureUser>(_configureUser);
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

  void _checkUserEmailVerification(
    CheckUserEmailVerification event,
    Emitter<UserState> emit,
  ) async {
    if (await _userRepo.checkEmailVerified()) {
      emit(state.copyWith(emailVerified: true));
    }
  }

  void _getUserDetail(
    GetUserDetail event,
    Emitter<UserState> emit,
  ) {
    _userRepo
        .getUserDetail(
      uid: _firebaseAuth.currentUser?.uid ?? "unknownUser",
      fromRemote: event.fromRemote,
    )
        .then((result) {
      if (result.isLeft) {
        result.left.showSnackBar(event.context);
      } else {
        emit(state.copyWith(userDetail: result.right));
      }
    });
  }

  void _configureUser(
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
          ),
        );
      }
      log(state.toString());
    } catch (e) {
      log("er[_configureUser][user_bloc.dart] $e");
      emit(const UserState.error("Something went wrong. Try again"));
    }
  }

  @override
  void onEvent(UserEvent event) {
    super.onEvent(event);
    log("Event dispatched: $event");
  }
}
