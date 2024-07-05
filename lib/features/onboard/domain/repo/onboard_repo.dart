abstract class OnboardRepo {
  bool getIsNewUser();

  Future<void> setIsNewUser({required bool isNew});

  bool getIsAdmin();

  Future<void> setIsAdmin({required bool isAdmin});
}