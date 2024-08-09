import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/config/hive/hive_keys.dart';

abstract class OnboardDataSource {
  bool getIsNewUser();

  Future<void> setIsNewUser({required bool isNew});
}

class OnboardDataSourceImpl implements OnboardDataSource {
  final Box<bool> _onboardBox;

  OnboardDataSourceImpl(this._onboardBox);

  @override
  bool getIsNewUser() => _onboardBox.get(HiveKeys.onboardIsNewKey) ?? true;

  @override
  Future<void> setIsNewUser({required bool isNew}) async =>
      await _onboardBox.put(
        HiveKeys.onboardIsNewKey,
        isNew,
      );
}
