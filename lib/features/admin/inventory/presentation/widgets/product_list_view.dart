import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/config/app_config.dart';
import '../../../../../core/util/widget/widget_loading.dart';
import '../../data/model/product_model.dart';

/// @author : Jibin K John
/// @date   : 22/08/2024
/// @time   : 13:47:09

class ProductListView extends StatelessWidget {
  final List<ProductModel> allProducts;
  final ValueNotifier<String> filter;

  const ProductListView({
    super.key,
    required this.allProducts,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100.0),
      shrinkWrap: true,
      itemCount: allProducts.length,
      itemBuilder: (ctx, index) {
        final product = allProducts[index];
        return Container(
          height: size.height * .15,
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            children: [
              // Featured image
              Container(
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.featuredImage,
                  fit: BoxFit.cover,
                  width: size.height * .13,
                  height: size.height * .13,
                  placeholder: (context, url) => WidgetLoading.rectangular(
                    type: LoadingType.featuredImage,
                    width: size.height * .13,
                    height: size.height * .13,
                  ),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.error,
                    size: 30.0,
                    color: Colors.red,
                  ),
                ),
              ),
              // Product info
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3.0),
                    Expanded(
                      child: Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          product.category.title,
                          style: const TextStyle(fontSize: 10.0),
                        ),
                        if (product.expiry != null)
                          Text(
                            " . Expiry in ${DateFormat.yMMMd().format(product.expiry!)}",
                            style: const TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                    const Divider(
                      thickness: .5,
                      color: Colors.grey,
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            AppConfig.priceFormat(product.price),
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade300,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            AppConfig.priceFormat(product.salePrice),
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Qty ",
                              style: TextStyle(fontSize: 10.0),
                            ),
                            Text(
                              "${product.quantity}",
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
