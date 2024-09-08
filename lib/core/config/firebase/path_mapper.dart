sealed class PathMapper {
  static const String _userRoot = "user";
  static const String _inventoryRoot = "inventory";
  static const String _reportRoot = "report";
  static const String _shopRoot = "shop";
  static const String _orderRoot = "order";

  static String userPath(String uid) => "$_userRoot/$uid";

  static String userInfoPath(String uid) => "$_userRoot/$uid/user_info";

  static String categoryPath = "$_inventoryRoot/category";
  static String productPath = "$_inventoryRoot/product";

  static String commentPath(String productId) =>
      "$_inventoryRoot/product/$productId/comments";

  static String reportPath(String uid) => "$_reportRoot/bug/$uid";

  static String feedbackPath(String uid) => "$_reportRoot/feedback/$uid";

  static String shopPath = _shopRoot;
  static String shopStatusPath = "$_shopRoot/status";
}
