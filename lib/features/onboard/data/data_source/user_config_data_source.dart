import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/config/hive/hive_keys.dart';

abstract class UserConfigDataSource {
  bool getIsNewUser();

  Future<void> setIsNewUser({required bool isNew});

  bool getIsAuthenticated();

  Future<void> setIsAuthenticated({required bool isAuth});

  bool getIsAdmin();

  Future<void> setIsAdmin({required bool isAdmin});
}

class UserConfigDataSourceImpl implements UserConfigDataSource {
  final Box<bool> _userConfigBox;

  UserConfigDataSourceImpl(this._userConfigBox);

  @override
  bool getIsAdmin() =>
      _userConfigBox.get(HiveKeys.userConfigIsAdminKey) ?? false;

  @override
  bool getIsAuthenticated() =>
      _userConfigBox.get(HiveKeys.userConfigIsAuthKey) ?? false;

  @override
  bool getIsNewUser() =>
      _userConfigBox.get(HiveKeys.userConfigIsNewKey) ?? true;

  @override
  Future<void> setIsAdmin({required bool isAdmin}) async =>
      await _userConfigBox.put(
        HiveKeys.userConfigIsAdminKey,
        isAdmin,
      );

  @override
  Future<void> setIsAuthenticated({required bool isAuth}) async =>
      await _userConfigBox.put(
        HiveKeys.userConfigIsAuthKey,
        isAuth,
      );

  @override
  Future<void> setIsNewUser({required bool isNew}) async =>
      await _userConfigBox.put(
        HiveKeys.userConfigIsNewKey,
        isNew,
      );
}
