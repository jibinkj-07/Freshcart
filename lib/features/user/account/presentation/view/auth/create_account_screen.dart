import 'package:flutter/material.dart';

/// @author : Jibin K John
/// @date   : 15/08/2024
/// @time   : 12:06:22

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("CreateAccountScreen"),
        centerTitle: true,
      ),
      body: Center(child: Text("CreateAccountScreen")),
    );
  }
}
