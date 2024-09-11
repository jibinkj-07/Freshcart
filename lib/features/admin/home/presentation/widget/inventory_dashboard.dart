import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../inventory/presentation/bloc/category_bloc.dart';
import '../../../inventory/presentation/bloc/product_bloc.dart';
import '../view_model/home_helper.dart';

/// @author : Jibin K John
/// @date   : 17/08/2024
/// @time   : 16:13:58

class InventoryDashboard extends StatelessWidget {
  const InventoryDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.only(top: 5.0, bottom: 20.0),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .colorScheme
            .surface,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (ctx, state) {
                        return ListTile(
                          tileColor: Colors.amber.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          leading: const Icon(
                            Icons.list_alt_rounded,
                            color: Colors.black54,
                          ),
                          title: const Text(
                            "Products",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.0,
                            ),
                          ),
                          subtitle: Text(
                            state.products.length.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ListTile(
                    tileColor: Colors.green.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    leading: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black54,
                    ),
                    title: const Text(
                      "Orders",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.0,
                      ),
                    ),
                    subtitle: const Text(
                      "230",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (ctx, state) {
                        return ListTile(
                          tileColor: Colors.deepPurple.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          leading: const Icon(
                            Icons.category_outlined,
                            color: Colors.black54,
                          ),
                          title: const Text(
                            "Categories",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.0,
                            ),
                          ),
                          subtitle: Text(
                            state.category.length.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (ctx, state) {
                      return ListTile(
                        tileColor: Colors.red.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        leading: const Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.black54,
                        ),
                        title: const Text(
                          "Out of stock",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12.0,
                          ),
                        ),
                        subtitle: Text(
                          HomeHelper.outOfStockProductsCount(state.products)
                              .toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
