import 'package:flutter/material.dart';
import '../../../../../core/util/widget/empty_animation.dart';
import '../../../../../core/util/widget/search_field.dart';
import '../../data/model/product_model.dart';
import 'product_list_view_builder.dart';

/// @author : Jibin K John
/// @date   : 22/08/2024
/// @time   : 13:47:09

class AllProductsView extends StatefulWidget {
  final List<ProductModel> allProducts;
  final ValueNotifier<String> filter;

  const AllProductsView({
    super.key,
    required this.allProducts,
    required this.filter,
  });

  @override
  State<AllProductsView> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<AllProductsView> {
  final ValueNotifier<String> _query = ValueNotifier("");

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ValueListenableBuilder(
      valueListenable: widget.filter,
      builder: (ctx, productFilter, _) {
        List<ProductModel> filteredProductList = List.from(widget.allProducts);
        if (productFilter.isNotEmpty) {
          filteredProductList = filteredProductList
              .where((item) => item.category.title == productFilter)
              .toList();
        }

        return filteredProductList.isNotEmpty
            ? Column(
                children: [
                  SearchField(
                    query: _query,
                    hintText: "search by name or category",
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: _query,
                      builder: (ctx, query, _) {
                        // Extracted query into variable "q"
                        final q = query.toLowerCase().trim();
                        // Another list to hold the searched products
                        List<ProductModel> searchedProductList =
                            List.from(filteredProductList);
                        if (query.isNotEmpty) {
                          searchedProductList = searchedProductList
                              .where(
                                (item) =>
                                    item.name.toLowerCase().contains(q) ||
                                    item.category.title
                                        .toLowerCase()
                                        .contains(q),
                              )
                              .toList();
                        }
                        return searchedProductList.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "   Total ${searchedProductList.length}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: ProductListViewBuilder(
                                      size: size,
                                      productList: searchedProductList,
                                    ),
                                  ),
                                ],
                              )
                            : EmptyAnimation(
                                size: size.width * .5,
                                message: "No products found for \"$query\"",
                              );
                      },
                    ),
                  ),
                ],
              )
            : EmptyAnimation(
                size: size.width * .5,
                message: "No products for \"$productFilter\"",
              );
      },
    );
  }
}
