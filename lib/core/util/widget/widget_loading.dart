import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

enum LoadingType { profile }

class WidgetLoading extends StatefulWidget {
  final LoadingType type;

  const WidgetLoading.rectangular({
    super.key,
    required this.type,
  });

  @override
  State<WidgetLoading> createState() => _WidgetLoadingState();
}

class _WidgetLoadingState extends State<WidgetLoading> {
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case LoadingType.profile:
        return profile();
    }
  }

  Widget profile() => Shimmer(
        direction: const ShimmerDirection.fromLeftToRight(),
        color: Theme.of(context).primaryColor,
        child: CircleAvatar(backgroundColor: Colors.grey.withOpacity(.2)),
      );
}
