import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

enum LoadingType { profile, featuredImage }

class WidgetLoading extends StatefulWidget {
  final LoadingType type;
  final double? width;
  final double? height;

  const WidgetLoading.rectangular({
    super.key,
    required this.type,
    this.width = 100.0,
    this.height = 100.0,
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
      case LoadingType.featuredImage:
        return featuredImage();
    }
  }

  Widget profile() => Shimmer(
        direction: const ShimmerDirection.fromLeftToRight(),
        color: Theme.of(context).primaryColor,
        child: CircleAvatar(backgroundColor: Colors.grey.withOpacity(.2)),
      );

  Widget featuredImage() => Shimmer(
        direction: const ShimmerDirection.fromLeftToRight(),
        color: Theme.of(context).primaryColor,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.2),
          ),
        ),
      );
}
