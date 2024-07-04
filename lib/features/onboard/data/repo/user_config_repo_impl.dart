import '../../domain/repo/user_config_repo.dart';
import '../data_source/user_config_data_source.dart';

class UserConfigRepoImpl implements UserConfigRepo {
  final UserConfigDataSource _configDataSource;

  UserConfigRepoImpl(this._configDataSource);

  @override
  bool getIsAdmin() => _configDataSource.getIsAdmin();

  @override
  bool getIsAuthenticated() => _configDataSource.getIsAuthenticated();

  @override
  bool getIsNewUser() => _configDataSource.getIsNewUser();

  @override
  Future<void> setIsAdmin({required bool isAdmin}) async =>
      await _configDataSource.setIsAdmin(isAdmin: isAdmin);

  @override
  Future<void> setIsAuthenticated({required bool isAuth}) async =>
      await _configDataSource.setIsAuthenticated(isAuth: isAuth);

  @override
  Future<void> setIsNewUser({required bool isNew}) async =>
      await _configDataSource.setIsNewUser(isNew: isNew);
}
