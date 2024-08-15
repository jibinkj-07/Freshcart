import 'package:flutter/material.dart';

/// @author : Jibin K John
/// @date   : 15/08/2024
/// @time   : 13:10:32

class AnimatedLoadingButton extends StatelessWidget {
  final bool loading;
  final Widget child;
  final Duration? duration;
  final double? borderRadius;
  final VoidCallback? onPressed;

  const AnimatedLoadingButton({
    super.key,
    required this.loading,
    required this.child,
    this.duration,
    this.borderRadius,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        ),
      ),
      child: AnimatedSwitcher(
        duration: duration ?? const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: loading
            ? SizedBox(
                height: 25.0,
                width: 25.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Theme.of(context).primaryColor.withOpacity(.8),
                ),
              )
            : child,
      ),
    );
  }
}
