import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/util/error/failure.dart';
import '../../domain/repo/user_repo.dart';
import 'auth_bloc.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepo _userRepo;
  final AuthBloc _authBloc;

  AccountBloc(this._userRepo, this._authBloc)
      : super(const AccountState.initial()) {
    on<AccountEvent>(
      (event, emit) async {
        switch (event) {
          case CreateAccount():
            await _createAccount(event, emit);
            break;
          case SendVerificationMail():
            await _sendVerificationMail(event, emit);
            break;
          case ResetPassword():
            await _resetPassword(event, emit);
            break;
          case CheckEmailVerification():
            await _checkEmailVerification(event, emit);
            break;
        }
      },
    );
  }

  // Events
  Future<void> _createAccount(
    CreateAccount event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountState(status: AccountStatus.creatingAccount));
    try {
      final result = await _userRepo.createAccount(
        email: event.email,
        password: event.password,
        name: event.name,
      );
      if (result.isLeft) {
        emit(AccountState.error(result.left));
      } else {
        _authBloc.add(
            AddUser(user: result.right, emailStatus: EmailStatus.notVerified));
        emit(const AccountState(status: AccountStatus.accountCreated));
      }
    } catch (e) {
      log("er: [_createAccount][account_bloc.dart] $e");
      emit(
        AccountState.error(
          Failure(message: "An unexpected error occurred"),
        ),
      );
    }
  }

  Future<void> _sendVerificationMail(
    SendVerificationMail event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountState(status: AccountStatus.sendingVerificationMail));
    try {
      final result = await _userRepo.sendVerificationMail();
      if (result.isLeft) {
        emit(AccountState.error(result.left));
      }
    } catch (e) {
      log("er: [_sendVerificationMail][account_bloc.dart] $e");
      emit(
        AccountState.error(
          Failure(message: "An unexpected error occurred"),
        ),
      );
    }
  }

  Future<void> _checkEmailVerification(
    CheckEmailVerification event,
    Emitter<AccountState> emit,
  ) async {
    try {
      final result = await _userRepo.checkEmailVerified();
      if (result) {
        _authBloc.add(
          const UpdateEmailStatus(emailStatus: EmailStatus.verified),
        );
        emit(const AccountState(status: AccountStatus.emailVerified));
      }
    } catch (e) {
      log("er: [_checkEmailVerification][account_bloc.dart] $e");
      emit(
        AccountState.error(
          Failure(message: "An unexpected error occurred"),
        ),
      );
    }
  }

  Future<void> _resetPassword(
    ResetPassword event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountState(status: AccountStatus.sendingResetInstruction));
    try {
      final result = await _userRepo.resetPassword(email: event.email);
      if (result.isLeft) {
        emit(AccountState.error(result.left));
      } else {
        emit(state.copyWith(status: AccountStatus.resetInstructionSent));
      }
    } catch (e) {
      log("er: [_resetPassword][account_bloc.dart] $e");
      emit(
        AccountState.error(
          Failure(message: "An unexpected error occurred"),
        ),
      );
    }
  }

  @override
  void onEvent(AccountEvent event) {
    super.onEvent(event);
    log("AccountEvent dispatched: $event");
  }
}
