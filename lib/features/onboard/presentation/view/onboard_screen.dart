import 'package:flutter/material.dart';
import '../widget/indicator.dart';
import '../widget/onboard_visual.dart';

/// @author : Jibin K John
/// @date   : 04/07/2024
/// @time   : 12:20:22

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final ValueNotifier<int> _index = ValueNotifier(0);

  @override
  void dispose() {
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(child: OnboardVisual(currentIndex: _index)),
            Indicator(index: _index),
          ],
        ),
      ),
    );
  }
}
