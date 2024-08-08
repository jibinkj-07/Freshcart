sealed class PathMapper {
  static const String _userRoot = "user";
  static const String _inventoryRoot = "inventory";

  static String userPath(String uid) => "$_userRoot/$uid";

  static String userInfoPath(String uid) => "$_userRoot/$uid/user_info";
}
