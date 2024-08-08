import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/presentation/bloc/user_bloc.dart';

/// @author : Jibin K John
/// @date   : 08/08/2024
/// @time   : 14:07:17

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("Check"),
        onPressed: () {
          context.read<UserBloc>().add(ConfigureUser());
        },
      ),
    );
  }
}
