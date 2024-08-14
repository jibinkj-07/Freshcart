import 'package:flutter/material.dart';

/// @author : Jibin K John
/// @date   : 14/08/2024
/// @time   : 16:06:08


class FeedbackScreen extends StatefulWidget {
const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("FeedbackScreen"),
        centerTitle: true,
      ),
      body: Center(child: Text("FeedbackScreen")),
    );
  }
}

