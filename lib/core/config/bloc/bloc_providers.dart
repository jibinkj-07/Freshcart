import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import '../../../features/admin/inventory/presentation/bloc/category_bloc.dart';
import '../../../features/admin/inventory/presentation/bloc/product_bloc.dart';
import '../../../features/common/presentation/bloc/account_bloc.dart';
import '../../../features/common/presentation/bloc/auth_bloc.dart';
import '../../../features/onboard/presentation/bloc/onboard_bloc.dart';
import '../../../features/theme/presentation/bloc/theme_bloc.dart';
import '../injection/injection_container.dart';

sealed class BlocProviders {
  static List<SingleChildWidget> get list => [
        BlocProvider<ThemeBloc>(create: (_) => sl<ThemeBloc>()),
        BlocProvider<OnboardBloc>(create: (_) => sl<OnboardBloc>()),
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<AccountBloc>(create: (_) => sl<AccountBloc>()),
        BlocProvider<CategoryBloc>(create: (_) => sl<CategoryBloc>()),
        BlocProvider<ProductBloc>(create: (_) => sl<ProductBloc>()),
      ];
}
