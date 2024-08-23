import '../../../core/config/app_config.dart';

sealed class UtilityHelper {
  static String getTitle(int index) {
    switch (index) {
      case 1:
        return "Inventory";
      case 2:
        return "Orders";
      case 3:
        return "My Shop";
      default:
        return AppConfig.appName;
    }
  }
}
