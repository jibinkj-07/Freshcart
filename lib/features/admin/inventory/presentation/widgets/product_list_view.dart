import 'package:flutter/material.dart';

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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: allProducts.length,
      itemBuilder: (ctx, index) {
        return ListTile(
          title: Text(allProducts[index].name),
        );
      },
    );
  }
}
