sealed class PathMapper {
  static const String _userRoot = "user";
  static const String _inventoryRoot = "inventory";
  static const String _reportRoot = "report";

  static String userPath(String uid) => "$_userRoot/$uid";

  static String userInfoPath(String uid) => "$_userRoot/$uid/user_info";

  static String reportPath(String uid) => "$_reportRoot/bug/$uid";
  static String feedbackPath(String uid) => "$_reportRoot/feedback/$uid";
}
