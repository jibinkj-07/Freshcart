import 'package:flutter/material.dart';
import '../view_model/onboard_helper.dart';

/// @author : Jibin K John
/// @date   : 04/07/2024
/// @time   : 15:25:19

class Indicator extends StatelessWidget {
  final ValueNotifier<int> index;

  const Indicator({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: index,
      builder: (ctx, i, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => OnboardHelper.onGetStarted(context),
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: const Text("Skip"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  width: i == index ? 10.0 : 8.0,
                  height: i == index ? 10.0 : 8.0,
                  margin: const EdgeInsets.only(right: 15.0),
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color:
                        i == index ? Colors.amber : Colors.grey.withOpacity(.5),
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  if (i != 2) {
                    index.value += 1;
                  } else {
                    OnboardHelper.onGetStarted(context);
                  }
                },
                child: const Text("Next")),
          ],
        );
      },
    );
  }
}
