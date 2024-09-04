import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'image_indicator.dart';
import 'widget_loading.dart';

/// @author : Jibin K John
/// @date   : 28/08/2024
/// @time   : 20:07:21

class ProductCarousel extends StatefulWidget {
  final List<String> imageUrlList;
  final String productName;
  final Widget child;
  final double? margin;

  const ProductCarousel({
    super.key,
    required this.productName,
    required this.imageUrlList,
    required this.child,
    this.margin,
  });

  @override
  State<ProductCarousel> createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
  final ValueNotifier<int> _index = ValueNotifier(0);

  @override
  void dispose() {
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            pinned: true,
            floating: true,
            expandedHeight: size.height * .35,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.productName,
                style: const TextStyle(fontSize: 18.0),
              ),
              background: Container(
                height: size.height * .35,
                // Height of the ListView
                margin: EdgeInsets.all(widget.margin ?? 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    PageView(
                      physics: const BouncingScrollPhysics(),
                      allowImplicitScrolling: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index) => _index.value = index,
                      children: List.generate(
                        widget.imageUrlList.length,
                        (index) => Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: widget.imageUrlList[index],
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  WidgetLoading.rectangular(
                                type: LoadingType.featuredImage,
                                width: size.width,
                                height: size.height * .35,
                              ),
                              errorWidget: (_, __, ___) => const Icon(
                                Icons.error,
                                size: 30.0,
                                color: Colors.red,
                              ),
                            ),

                            // Black overlay
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: size.height * 0.15,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Theme.of(context)
                                          .scaffoldBackgroundColor
                                          .withOpacity(.85),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5.0,
                      left: 0.0,
                      right: 0.0,
                      child: ImageIndicator(
                        index: _index,
                        totalImages: widget.imageUrlList.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
