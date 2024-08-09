import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/route/route_mapper.dart';
import '../bloc/onboard_bloc.dart';

sealed class OnboardHelper {
  static Future<void> onGetStarted(BuildContext context) async {
    // setting isNewUser to false
    await context.read<OnboardBloc>().setIsNewUser(false);
    // Check if the widget is still mounted before navigating
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(RouteMapper.userHomeScreen);
    }
  }
}
