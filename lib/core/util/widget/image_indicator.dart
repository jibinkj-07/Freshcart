import 'package:flutter/material.dart';

import '../../config/app_config.dart';

class ImageIndicator extends StatelessWidget {
  final ValueNotifier<int> index;

  const ImageIndicator({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: index,
      builder: (ctx, i, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (index) => AnimatedContainer(
            width: i == index ? 20.0 : 8.0,
            height: 8.0,
            margin: const EdgeInsets.only(right: 15.0),
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: i == index ? AppConfig.appColor : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
