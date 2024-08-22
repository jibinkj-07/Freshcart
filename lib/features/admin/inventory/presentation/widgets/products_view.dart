import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/widget/empty_animation.dart';
import '../bloc/product_bloc.dart';
import 'product_list_view.dart';

/// @author : Jibin K John
/// @date   : 22/08/2024
/// @time   : 13:37:48

class ProductsView extends StatelessWidget {
  final ValueNotifier<String> filter;

  const ProductsView({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (ctx, state) {
        if (state.status == ProductStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.products.isNotEmpty) {
          return ProductListView(
            filter: filter,
            allProducts: state.products,
          );
        }
        return EmptyAnimation(
          size: MediaQuery.sizeOf(context).width * .5,
          message: "No Products",
        );
      },
    );
  }
}
