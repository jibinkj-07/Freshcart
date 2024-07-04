import 'package:flutter/material.dart';
import '../../../features/admin/home/presentation/view/admin_home_screen.dart';
import '../../../features/onboard/presentation/view/onboard_screen.dart';
import '../../../features/user/home/presentations/view/user_home_screen.dart';
import 'error_route.dart';
import 'route_mapper.dart';

sealed class AppRoutes {
  static Route<dynamic> generate(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteMapper.root:
        return MaterialPageRoute(
          builder: (_) =>
              // OnboardScreen(isDataFetched: args == null ? false : args as bool),
              const OnboardScreen(),
        );
      case RouteMapper.onboard:
        return MaterialPageRoute(builder: (_) => const OnboardScreen());
      case RouteMapper.userHomeScreen:
        return MaterialPageRoute(builder: (_) => const UserHomeScreen());
      case RouteMapper.adminHomeScreen:
        return MaterialPageRoute(builder: (_) => const AdminHomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorRoute());
    }
  }
}
