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
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (ctx, state) {
          final index = state.products.indexWhere(
            (item) => item.id == widget.productId,
          );

          if (index < 0) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2.0),
            );
          }
          final product = state.products[index];
          return ProductCarousel(
            imageUrlList: [...product.images, product.featuredImage],
            productName: product.name,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            AppConfig.priceFormat(product.priceAfterDiscount),
                            style: const TextStyle(color: Colors.black),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          side: const BorderSide(color: Colors.green),
                          backgroundColor: Colors.green,
                        ),
                        const SizedBox(width: 10.0),
                        Chip(
                          label: Text(
                            product.category.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          side: const BorderSide(color: Colors.deepPurple),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Colors.deepPurple,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                          foregroundColor: AppConfig.appColor),
                      icon: const Icon(Icons.edit_rounded),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(product.description),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: _tile(
                        "MRP",
                        AppConfig.priceFormat(product.salePrice),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: _tile(
                        "Actual Price",
                        AppConfig.priceFormat(product.price),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: _tile(
                        "Profit",
                        AppConfig.priceFormat(
                            product.priceAfterDiscount - product.price),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: _tile("Quantity", "${product.quantity}"),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: _tile(
                        "Discount",
                        "${product.offerPercentage} %",
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: _tile(
                        "Expiry",
                        product.expiry == null
                            ? "Not applicable"
                            : DateFormat.yMMMd().format(product.expiry!),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20.0),
                  child: OutlinedButton(
                    onPressed: () => _onDelete(product.id),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(
                        color: Colors.red.shade400,
                      ),
                    ),
                    child: Text("Delete ${product.name}"),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _tile(String title, String value) => Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.grey, width: .3),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13.0,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      );

  // Functions
  void _onDelete(String productId) {
    showDialog(
      context: context,
      builder: (ctx) => BlocConsumer<ProductBloc, ProductState>(
        builder: (ctx1, state) {
          return AlertDialog(
            title: Text(
              state.status == ProductStatus.deleting ? "Deleting" : "Delete",
            ),
            content: state.status == ProductStatus.deleting
                ? const SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2.0),
                    ),
                  )
                : const Text("Are you sure want to delete this product?"),
            actions: state.status == ProductStatus.deleting
                ? null
                : [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<ProductBloc>()
                            .add(DeleteProduct(productId: productId));
                      },
                      child: const Text("Delete"),
                    ),
                  ],
          );
        },
        listener: (BuildContext ctx2, ProductState state) {
          if (state.status == ProductStatus.deleted) {
            Navigator.pop(ctx);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
