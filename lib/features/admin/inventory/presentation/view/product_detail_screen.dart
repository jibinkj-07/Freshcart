import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/config/app_config.dart';
import '../../../../../core/util/widget/product_carousel.dart';
import '../bloc/product_bloc.dart';

/// @author : Jibin K John
/// @date   : 28/08/2024
/// @time   : 19:44:28

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(builder: (ctx, state) {
        final index = state.products.indexWhere(
          (item) => item.id == widget.productId,
        );

        if (index < 0) {
          return const Center(
              child: CircularProgressIndicator(strokeWidth: 2.0));
        }
        final product = state.products[index];
        return ProductCarousel(
          imageUrlList: [...product.images, product.featuredImage],
          productName: product.name,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.description),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                decoration:
                    BoxDecoration(color: Theme.of(context).colorScheme.surface),
                child: Column(
                  children: [
                    _tile("Category", product.category.title),
                    _tile(
                      "Actual Price",
                      AppConfig.priceFormat(product.price),
                    ),
                    _tile(
                      "Sale Price",
                      AppConfig.priceFormat(product.salePrice),
                    ),
                    _tile(
                        "Profit",
                        AppConfig.priceFormat(
                            product.salePrice - product.price)),
                    _tile("Quantity", "${product.quantity}"),
                    _tile(
                        "Expiry",
                        product.expiry == null
                            ? "Not applicable"
                            : DateFormat.yMMMd().format(product.expiry!)),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _tile(String title, String value) => ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 13.0,
            color: Colors.grey,
          ),
        ),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: 14.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
}
