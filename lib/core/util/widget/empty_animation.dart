import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../helper/asset_mapper.dart';

/// @author : Jibin K John
/// @date   : 08/08/2024
/// @time   : 13:57:16

class EmptyAnimation extends StatelessWidget {
  final double? size;
  final String? message;

  const EmptyAnimation({
    super.key,
    this.size,
    this.message,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            AssetMapper.emptyBoxLottie,
            width: size,
            height: size,
          ),
          if (message != null) Text(message!)
        ],
      );
}
