import 'package:flutter/material.dart';

/// @author : Jibin K John
/// @date   : 04/07/2024
/// @time   : 15:39:07


class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("UserHomeScreen"),
        centerTitle: true,
      ),
      body: Center(child: Text("UserHomeScreen")),
    );
  }
}

