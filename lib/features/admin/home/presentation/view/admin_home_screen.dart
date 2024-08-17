import 'package:flutter/material.dart';

import '../../../inventory/presentation/view/inventory_view.dart';
import '../../../orders/presentation/view/order_view.dart';
import '../../../shop/presentation/view/shop_view.dart';
import '../../../util/admin_top_bar.dart';
import '../widget/nav_bar.dart';
import 'home_view.dart';

/// @author : Jibin K John
/// @date   : 04/07/2024
/// @time   : 16:21:55

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final ValueNotifier<int> _index = ValueNotifier(0);
  final List<Widget> _views = const [
    HomeView(),
    InventoryView(),
    OrderView(),
    ShopView(),
  ];

  @override
  void dispose() {
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _index,
      builder: (ctx, index, _) {
        return PopScope(
          onPopInvokedWithResult: (_, __) => _index.value = 0,
          canPop: index == 0,
          child: Scaffold(
            appBar: AdminTopBar(selectedIndex: index),
            body: _views[index],
            bottomNavigationBar: NavBar(index: _index, selectedIndex: index),
          ),
        );
      },
    );
  }
}
