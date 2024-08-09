import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import '../../../features/common/presentation/bloc/user_bloc.dart';
import '../../../features/onboard/presentation/bloc/onboard_bloc.dart';
import '../../../features/theme/presentation/bloc/theme_bloc.dart';
import '../injection/injection_container.dart';

sealed class BlocProviders {
  static List<SingleChildWidget> get list => [
        BlocProvider<ThemeBloc>(create: (_) => sl<ThemeBloc>()),
        BlocProvider<OnboardBloc>(create: (_) => sl<OnboardBloc>()),
        BlocProvider<UserBloc>(create: (_) => sl<UserBloc>()),
      ];
}
