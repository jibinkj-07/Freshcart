import 'package:flutter/material.dart';

/// @author : Jibin K John
/// @date   : 04/07/2024
/// @time   : 16:21:55


class AdminHomeScreen extends StatelessWidget {
const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("AdminHomeScreen"),
        centerTitle: true,
      ),
      body: Center(child: Text("AdminHomeScreen")),
    );
  }
}

