import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/repo/onboard_repo.dart';

part 'onboard_event.dart';

part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  final OnboardRepo _onboardRepo;

  OnboardBloc(this._onboardRepo) : super(const OnboardState.unknown()) {
    on<OnboardEvent>((event, emit) async {
      switch (event) {
        case AppStarted():
          final isNew = _onboardRepo.getIsNewUser();
          final isAdmin = _onboardRepo.getIsAdmin();
          if (isNew) {
            emit(const OnboardState.onboarding());
          } else if (isAdmin) {
            emit(const OnboardState.adminAccess());
          } else {
            // if user is not new and may be authenticated or not
            emit(const OnboardState.unknown());
          }
          break;
        case SetIsNewUser():
          await _onboardRepo.setIsNewUser(isNew: event.isNew);
          break;
        case SetIsAdmin():
          await _onboardRepo.setIsAdmin(isAdmin: event.isAdmin);
          break;
      }
    });
  }
}
