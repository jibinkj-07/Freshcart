import 'package:flutter/material.dart';

import '../../../../../../core/config/route/route_mapper.dart';
import '../account_widget_helper.dart';

/// @author : Jibin K John
/// @date   : 15/08/2024
/// @time   : 11:49:13

class LoginSection extends StatelessWidget {
  const LoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Not signed in yet?",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
            ),
          ),
          AccountWidgetHelper.spacer(height: 8.0),
          const Text(
            "Sign in to access enhanced features",
            style: TextStyle(fontSize: 12.0),
          ),
          AccountWidgetHelper.spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(RouteMapper.loginScreen),
                child: const Text("Sign in"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  RouteMapper.createAccountScreen,
                ),
                child: const Text("Create Account"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
