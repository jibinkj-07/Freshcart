import 'package:flutter/material.dart';

import '../widget/inventory_dashboard.dart';
import '../widget/sales_graph.dart';
import '../widget/shop_status.dart';

/// @author : Jibin K John
/// @date   : 17/08/2024
/// @time   : 15:42:03

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: const [
        // Shop status
        ShopStatus(),
        // Inventory dashboard
        SizedBox(height: 20.0),
        Text("Dashboard"),
        InventoryDashboard(),
        // Sales graph
        Text("Sales Graph"),
        SalesGraph(),
      ],
    );
  }
}
