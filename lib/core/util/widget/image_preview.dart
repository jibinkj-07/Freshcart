import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../config/app_config.dart';
import '../helper/asset_mapper.dart';

class ImagePreview extends StatelessWidget {
  final String title;
  final String url;
  final String? tag;

  const ImagePreview({
    super.key,
    required this.title,
    required this.url,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF1F1F1F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F).withOpacity(.8),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
          splashRadius: 20.0,
        ),
      ),
      body: SizedBox.expand(
        child: InteractiveViewer(
          child: Center(
            child: Hero(
              tag: tag ?? 'profileAvatar',
              child: SizedBox(
                height: size.height * .5,
                width: size.width,
                child: url.isEmpty
                    ? Image.asset(AssetMapper.profileImage)
                    : CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (
                          context,
                          url,
                          downloadProgress,
                        ) =>
                            CircularProgressIndicator(
                          color: AppConfig.appColor,
                          value: downloadProgress.progress,
                        ),
                        errorWidget: (
                          context,
                          url,
                          error,
                        ) =>
                            const Icon(Icons.error, color: Colors.red),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
