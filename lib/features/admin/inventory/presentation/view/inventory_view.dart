import 'package:flutter/material.dart';

import '../widgets/category_header.dart';

/// @author : Jibin K John
/// @date   : 17/08/2024
/// @time   : 15:46:49

class InventoryView extends StatefulWidget {
  const InventoryView({super.key});

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  final ValueNotifier<String> _filter = ValueNotifier("All");

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CategoryHeader(filter: _filter),
      ],
    );
  }
}
