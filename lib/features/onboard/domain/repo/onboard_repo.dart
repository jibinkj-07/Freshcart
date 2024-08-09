abstract class OnboardRepo {
  bool getIsNewUser();

  Future<void> setIsNewUser({required bool isNew});
}