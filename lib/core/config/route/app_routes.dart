import 'package:flutter/material.dart';
import '../../../features/admin/home/presentation/view/admin_home_screen.dart';
import '../../../features/onboard/presentation/view/onboard_screen.dart';
import '../../../features/user/home/presentations/view/user_home_screen.dart';
import '../../../root.dart';
import '../../util/widget/loading.dart';
import 'error_route.dart';
import 'route_mapper.dart';

sealed class AppRoutes {
  static Route<dynamic> generate(RouteSettings settings) {
    final args = settings.arguments;

    /// for get parameters that are passed via navigator
    // OnboardScreen(isDataFetched: args == null ? false : args as bool),
    switch (settings.name) {
      case RouteMapper.root:
        return MaterialPageRoute(builder: (_) => const Root());
      case RouteMapper.loading:
        return MaterialPageRoute(builder: (_) => const Loading());
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
