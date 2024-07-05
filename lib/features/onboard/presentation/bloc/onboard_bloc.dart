import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/repo/onboard_repo.dart';

part 'onboard_event.dart';

part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  final OnboardRepo _onboardRepo;

  OnboardBloc(this._onboardRepo) : super(const OnboardState.unknown()) {
    on<OnboardEvent>((event, emit) async {
      if (event is AppStarted) {
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
      }
    });
  }

  Future<void> setIsNewUser(bool isNew) async =>
      await _onboardRepo.setIsNewUser(isNew: isNew);

  Future<void> setIsAdmin(bool isAdmin) async =>
      await _onboardRepo.setIsAdmin(isAdmin: isAdmin);
}
