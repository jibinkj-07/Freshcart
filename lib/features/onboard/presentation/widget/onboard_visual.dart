import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/util/animations/fade_in_down_animation.dart';
import '../../../../core/util/helper/asset_mapper.dart';

/// @author : Jibin K John
/// @date   : 04/07/2024
/// @time   : 14:49:52

class OnboardVisual extends StatelessWidget {
  final ValueNotifier<int> currentIndex;

  const OnboardVisual({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      AssetMapper.onboard1SVG,
      AssetMapper.onboard2SVG,
      AssetMapper.onboard3SVG,
    ];

    final List<String> title = [
      "Welcome aboard!",
      "Exclusive Deals Await",
      "Hassle-Free Shopping"
    ];
    final List<String> message = [
      "Your journey to seamless shopping begins here. Welcome aboard!",
      "Join Freshcart today and unlock exclusive deals just for you",
      "Explore endless possibilities with Freshcart. Get ready to shop hassle-free!"
    ];

    return FadeInDownAnimation(
      duration: const Duration(seconds: 2),
      child: ValueListenableBuilder(
        valueListenable: currentIndex,
        builder: (ctx, index, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(images[index]),
              Text(
                title[index],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              Text(
                message[index],
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
