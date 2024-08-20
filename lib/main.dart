import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/bloc/bloc_providers.dart';
import 'core/config/config_helper.dart';
import 'core/config/hive/hive_config.dart';
import 'core/config/injection/injection_container.dart';
import 'core/config/route/app_routes.dart';
import 'core/config/route/route_mapper.dart';
import 'core/config/theme/dark.dart';
import 'core/config/theme/light.dart';
import 'features/admin/inventory/presentation/bloc/category_bloc.dart';
import 'features/admin/inventory/presentation/bloc/product_bloc.dart';
import 'features/common/presentation/bloc/auth_bloc.dart';
import 'features/onboard/presentation/bloc/onboard_bloc.dart';
import 'features/theme/presentation/bloc/theme_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Setting up firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Initialising hive database
  await HiveConfig.init();

  // Initialising injection container
  await initDependencies();

  sl<OnboardBloc>().add(AppStarted());
  sl<ThemeBloc>().add(GetAppTheme());
  sl<AuthBloc>().add(InitUser());
  sl<CategoryBloc>().add(GetAllCategory());
  sl<ProductBloc>().add(GetAllProduct());

  // restricting application orientation to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
      MultiBlocProvider(
        providers: BlocProviders.list,
        child: const FreshcartApp(),
      ),
    ),
  );
}

class FreshcartApp extends StatelessWidget {
  const FreshcartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (ctx, state) {
        return MaterialApp(
          title: ConfigHelper.appName,
          theme: LightTheme.schema,
          darkTheme: DarkTheme.schema,
          themeMode: state.themeMode,
          initialRoute: RouteMapper.root,
          onGenerateRoute: AppRoutes.generate,
        );
      },
    );
  }
}
