import 'package:fresh_cart/core/config/injection/imports.dart';

import '../../../../core/config/hive/hive_keys.dart';
import '../model/user_model.dart';

abstract class UserCacheDataSource {
  Future<void> storeUser({required UserModel user});

  Future<UserModel?> getUser();

  Future<void> updatePicture({required String url});

  Future<void> clearData();
}

class UserCacheDataSourceImpl implements UserCacheDataSource {
  final Box<UserModel> _userBox;

  UserCacheDataSourceImpl(this._userBox);

  @override
  Future<void> clearData() async => await _userBox.clear();

  @override
  Future<UserModel?> getUser() async => _userBox.get(HiveKeys.userKey);

  @override
  Future<void> storeUser({required UserModel user}) async =>
      await _userBox.put(HiveKeys.userKey, user);

  @override
  Future<void> updatePicture({required String url}) async {
    final user = _userBox.get(HiveKeys.userKey);
    if (user != null) {
      await _userBox.put(user.uid, user.copyWith(imageUrl: url));
    }
  }
}
