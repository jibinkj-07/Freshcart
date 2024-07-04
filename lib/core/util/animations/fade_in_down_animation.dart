import 'package:flutter/material.dart';

/// @author : Jibin K John
/// @date   : 04/07/2024
/// @time   : 14:48:03

class FadeInDownAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeInDownAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<FadeInDownAnimation> createState() => _FadeInDownAnimationState();
}

class _FadeInDownAnimationState extends State<FadeInDownAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(begin: -30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Transform.translate(
            offset: Offset(0.0, _animation.value),
            child: widget.child,
          ),
        );
      },
    );
  }
}
