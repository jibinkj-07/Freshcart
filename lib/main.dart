import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/config/hive/hive_config.dart';
import 'core/config/injection/injection_container.dart';
import 'core/config/route/app_routes.dart';
import 'core/config/route/route_mapper.dart';
import 'core/config/theme/dark.dart';
import 'core/config/theme/light.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialising hive database
  await HiveConfig.init();

  // Initialising injection container
  await initDependencies();

  // restricting application orientation to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(const FreshcartApp()));
}

class FreshcartApp extends StatelessWidget {
  const FreshcartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freshcart',
      theme: LightTheme.schema,
      darkTheme: DarkTheme.schema,
      themeMode: ThemeMode.system,
      initialRoute: RouteMapper.root,
      onGenerateRoute: AppRoutes.generate,
    );
  }
}
