import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import '../../../features/common/presentation/bloc/user_bloc.dart';
import '../../../features/onboard/presentation/bloc/onboard_bloc.dart';
import '../../../features/theme/presentation/bloc/theme_bloc.dart';
import '../injection/injection_container.dart';

sealed class BlocProviders {
  static List<SingleChildWidget> get list => [
        BlocProvider<UserBloc>(
          create: (_) => sl<UserBloc>()..add(ConfigureUser()),
        ),
        BlocProvider<ThemeBloc>(
          create: (_) => sl<ThemeBloc>()..add(GetAppTheme()),
        ),
        BlocProvider<OnboardBloc>(
          create: (_) => sl<OnboardBloc>()..add(AppStarted()),
        ),
      ];
}
