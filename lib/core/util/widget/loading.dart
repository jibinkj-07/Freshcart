import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../config/theme/dark.dart';
import '../helper/asset_mapper.dart';

/// @author : Jibin K John
/// @date   : 05/07/2024
/// @time   : 19:34:15

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          Theme.of(context).scaffoldBackgroundColor == DarkTheme.bgColor
              ? AssetMapper.loadingDarkLottie
              : AssetMapper.loadingLottie,
          width: size.width * .5,
        ),
      ),
    );
  }
}
