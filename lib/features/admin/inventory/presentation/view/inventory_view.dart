import 'package:flutter/material.dart';

import '../widgets/category_header.dart';
import '../widgets/products_view.dart';

/// @author : Jibin K John
/// @date   : 17/08/2024
/// @time   : 15:46:49

class InventoryView extends StatefulWidget {
  const InventoryView({super.key});

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  final ValueNotifier<String> _filter = ValueNotifier("");

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CategoryHeader(filter: _filter),
          Expanded(child: ProductsView(filter: _filter)),
        ],
      ),
    );
  }
}
