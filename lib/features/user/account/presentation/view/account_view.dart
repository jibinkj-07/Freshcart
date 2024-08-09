import 'package:flutter/material.dart';
import '../widget/theme_selector.dart';

/// @author : Jibin K John
/// @date   : 08/08/2024
/// @time   : 14:07:17

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
       ThemeSelector(),
      ],
    );
  }
}
