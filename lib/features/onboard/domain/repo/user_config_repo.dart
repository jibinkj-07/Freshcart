abstract class UserConfigRepo {
  bool getIsNewUser();

  Future<void> setIsNewUser({required bool isNew});

  bool getIsAuthenticated();

  Future<void> setIsAuthenticated({required bool isAuth});

  bool getIsAdmin();

  Future<void> setIsAdmin({required bool isAdmin});
}