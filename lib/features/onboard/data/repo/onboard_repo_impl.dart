import '../../domain/repo/onboard_repo.dart';
import '../data_source/onboard_data_source.dart';

class OnboardRepoImpl implements OnboardRepo {
  final OnboardDataSource _configDataSource;

  OnboardRepoImpl(this._configDataSource);

  @override
  bool getIsAdmin() => _configDataSource.getIsAdmin();


  @override
  bool getIsNewUser() => _configDataSource.getIsNewUser();

  @override
  Future<void> setIsAdmin({required bool isAdmin}) async =>
      await _configDataSource.setIsAdmin(isAdmin: isAdmin);


  @override
  Future<void> setIsNewUser({required bool isNew}) async =>
      await _configDataSource.setIsNewUser(isNew: isNew);
}
