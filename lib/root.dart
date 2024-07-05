import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/route/route_mapper.dart';
import 'features/onboard/presentation/bloc/onboard_bloc.dart';
import 'features/user/home/presentations/view/user_home_screen.dart';

/// @author : Jibin K John
/// @date   : 05/07/2024
/// @time   : 18:23:31

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardBloc, OnboardState>(
      listener: (ctx, state) {
        if (state.status == OnboardStatus.unknown) {
          Navigator.pushReplacementNamed(context, RouteMapper.loading);
        } else if (state.status == OnboardStatus.onboarding) {
          Navigator.pushReplacementNamed(context, RouteMapper.onboard);
        } else if (state.status == OnboardStatus.adminAccess) {
          Navigator.pushReplacementNamed(context, RouteMapper.adminHomeScreen);
        }
      },
      child: const UserHomeScreen(),
    );
  }
}
