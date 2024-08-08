import 'package:flutter/material.dart';

import '../../../account/presentation/view/account_view.dart';
import '../../../cart/presentation/view/cart_view.dart';
import '../../../category/presentation/view/category_view.dart';
import '../../../util/user_top_bar.dart';
import '../widget/nav_bar.dart';
import 'home_view.dart';

/// @author : Jibin K John
/// @date   : 04/07/2024
/// @time   : 15:39:07

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final ValueNotifier<int> _index = ValueNotifier(0);
  final List<Widget> _views = const [
    HomeView(),
    CategoryView(),
    AccountView(),
    CartView(),
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
          onPopInvoked: (_) => _index.value = 0,
          canPop: index == 0,
          child: Scaffold(
            appBar: UserTopBar(selectedIndex: index),
            body: _views[index],
            bottomNavigationBar: NavBar(index: _index, selectedIndex: index),
          ),
        );
      },
    );
  }
}
