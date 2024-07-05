import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/config/hive/hive_keys.dart';

abstract class OnboardDataSource {
  bool getIsNewUser();

  Future<void> setIsNewUser({required bool isNew});

  bool getIsAdmin();

  Future<void> setIsAdmin({required bool isAdmin});
}

class OnboardDataSourceImpl implements OnboardDataSource {
  final Box<bool> _onboardBox;

  OnboardDataSourceImpl(this._onboardBox);

  @override
  bool getIsAdmin() =>
      _onboardBox.get(HiveKeys.onboardIsAdminKey) ?? false;


  @override
  bool getIsNewUser() =>
      _onboardBox.get(HiveKeys.onboardIsNewKey) ?? true;

  @override
  Future<void> setIsAdmin({required bool isAdmin}) async =>
      await _onboardBox.put(
        HiveKeys.onboardIsAdminKey,
        isAdmin,
      );

  @override
  Future<void> setIsNewUser({required bool isNew}) async =>
      await _onboardBox.put(
        HiveKeys.onboardIsNewKey,
        isNew,
      );
}
