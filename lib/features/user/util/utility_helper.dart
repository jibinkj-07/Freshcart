import '../../../core/config/app_config.dart';

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
        return AppConfig.appName;
    }
  }
}
