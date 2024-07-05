import 'package:flutter/material.dart';

/// @author : Jibin K John
/// @date   : 05/07/2024
/// @time   : 19:34:15

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
