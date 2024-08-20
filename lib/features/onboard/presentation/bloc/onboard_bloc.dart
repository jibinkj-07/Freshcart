import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/repo/onboard_repo.dart';

part 'onboard_event.dart';

part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  final OnboardRepo _onboardRepo;

  OnboardBloc(this._onboardRepo) : super(const OnboardState.loading()) {
    on<OnboardEvent>((event, emit) async {
      if (event is AppStarted) {
        final isNew = _onboardRepo.getIsNewUser();
        if (isNew) {
          emit(const OnboardState.onboard());
        } else {
          emit(const OnboardState.onboarded());
        }
      }
    });
  }

  Future<void> setIsNewUser(bool isNew) async =>
      await _onboardRepo.setIsNewUser(isNew: isNew);

  @override
  void onEvent(OnboardEvent event) {
    super.onEvent(event);
    log("OnboardEvent dispatched: $event");
  }
}
