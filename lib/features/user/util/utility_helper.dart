import '../../../core/config/config_helper.dart';

sealed class UtilityHelper {
  static String getTitle(int index) {
    switch (index) {
      case 1:
        return "Category";
      case 2:
        return "Account";
      case 3:
        return "My Cart";
      default:
        return ConfigHelper.appName;
    }
  }
}
