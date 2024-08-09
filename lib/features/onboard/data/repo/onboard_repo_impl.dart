import '../../domain/repo/onboard_repo.dart';
import '../data_source/onboard_data_source.dart';

class OnboardRepoImpl implements OnboardRepo {
  final OnboardDataSource _configDataSource;

  OnboardRepoImpl(this._configDataSource);

  @override
  bool getIsNewUser() => _configDataSource.getIsNewUser();

  @override
  Future<void> setIsNewUser({required bool isNew}) async =>
      await _configDataSource.setIsNewUser(isNew: isNew);
}
