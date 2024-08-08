import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../helper/asset_mapper.dart';

/// @author : Jibin K John
/// @date   : 08/08/2024
/// @time   : 13:57:16

class EmptyAnimation extends StatelessWidget {
  final double? size;

  const EmptyAnimation({super.key, this.size});

  @override
  Widget build(BuildContext context) => Center(
        child: Lottie.asset(
          AssetMapper.emptyBoxLottie,
          width: size,
          height: size,
        ),
      );
}
