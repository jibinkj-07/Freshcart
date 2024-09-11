import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/util/widget/loading.dart';
import 'features/admin/home/presentation/view/admin_home_screen.dart';
import 'features/common/presentation/bloc/auth_bloc.dart';
import 'features/onboard/presentation/bloc/onboard_bloc.dart';
import 'features/onboard/presentation/view/onboard_screen.dart';
import 'features/user/home/presentations/view/user_home_screen.dart';

/// @author : Jibin K John
/// @date   : 05/07/2024
/// @time   : 18:23:31

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardBloc, OnboardState>(
      builder: (ctx, onboardState) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (ctx, authState) {
            switch (onboardState.status) {
              case OnboardStatus.onboard:
                return const OnboardScreen();
              case OnboardStatus.onboarded:
                if (authState.userInfo!.isAdmin) {
                  return const AdminHomeScreen();
                } else {
                  return const UserHomeScreen();
                }

              default:
                return const Loading();
            }
          },
        );
      },
    );
  }
}
