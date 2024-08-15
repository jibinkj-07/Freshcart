import 'package:flutter/material.dart';

/// @author : Jibin K John
/// @date   : 15/08/2024
/// @time   : 16:00:53


class EmailVerificationScreen extends StatefulWidget {
const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("EmailVerificationScreen"),
        centerTitle: true,
      ),
      body: Center(child: Text("EmailVerificationScreen")),
    );
  }
}

