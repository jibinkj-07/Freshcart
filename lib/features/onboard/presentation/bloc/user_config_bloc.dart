import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/repo/user_config_repo.dart';

part 'user_config_event.dart';

part 'user_config_state.dart';

class UserConfigBloc extends Bloc<UserConfigEvent, UserConfigState> {
  final UserConfigRepo _configRepo;

  UserConfigBloc(this._configRepo) : super(const UserConfigInitial()) {
    on<UserConfigEvent>((event, emit) async {
      switch (event) {
        case GetIsNewUser():
          emit(UserConfigState(
            isNewUser: _configRepo.getIsNewUser(),
            isAdmin: state.isAdmin,
            isAuthenticated: state.isAuthenticated,
          ));
          break;
        case GetIsAuthenticated():
          emit(UserConfigState(
            isNewUser: state.isNewUser,
            isAdmin: state.isAdmin,
            isAuthenticated: _configRepo.getIsAuthenticated(),
          ));
          break;
        case GetIsAdmin():
          emit(UserConfigState(
            isNewUser: state.isNewUser,
            isAdmin: _configRepo.getIsAdmin(),
            isAuthenticated: state.isAuthenticated,
          ));
          break;
        case SetIsNewUser():
          await _configRepo.setIsNewUser(isNew: event.isNew);
          emit(UserConfigState(
            isNewUser: event.isNew,
            isAdmin: state.isAdmin,
            isAuthenticated: state.isAuthenticated,
          ));
          break;
        case SetIsAuthenticated():
          await _configRepo.setIsAuthenticated(isAuth: event.isAuth);
          emit(UserConfigState(
            isNewUser: state.isNewUser,
            isAdmin: state.isAdmin,
            isAuthenticated: event.isAuth,
          ));
          break;
        case SetIsAdmin():
          await _configRepo.setIsAdmin(isAdmin: event.isAdmin);
          emit(UserConfigState(
            isNewUser: state.isNewUser,
            isAdmin: event.isAdmin,
            isAuthenticated: state.isAuthenticated,
          ));
          break;
      }
    });
  }
}
