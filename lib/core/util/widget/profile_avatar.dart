import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../config/route/custom_tween.dart';
import '../helper/asset_mapper.dart';
import 'widget_loading.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;
  final String imageUrl;
  final Color? borderColor;
  final String? tag;
  final Function()? onPressed;

  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    this.onPressed,
    this.radius = 100.0,
    this.tag,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag ?? 'profileAvatar',
      createRectTween: tag != null
          ? (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            }
          : null,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: radius,
          width: radius,
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: borderColor ?? Colors.grey.withOpacity(.5),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(500.0),
            child: imageUrl.isEmpty
                ? Image.asset(AssetMapper.profileImage)
                : CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const WidgetLoading.rectangular(
                      type: LoadingType.profile,
                    ),
                    errorWidget: (_, __, ___) => Icon(
                      Icons.error,
                      size: radius * .3,
                      color: Colors.red,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
