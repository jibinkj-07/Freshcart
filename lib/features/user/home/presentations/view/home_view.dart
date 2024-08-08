import 'package:flutter/material.dart';

import '../../../../../core/util/widget/empty_animation.dart';

/// @author : Jibin K John
/// @date   : 08/08/2024
/// @time   : 14:06:18

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EmptyAnimation(size: MediaQuery.sizeOf(context).width * .5),
        const Text("No products available at the moment.")
      ],
    );
  }
}
