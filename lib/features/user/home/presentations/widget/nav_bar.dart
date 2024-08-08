import 'package:flutter/material.dart';

/// @author : Jibin K John
/// @date   : 08/08/2024
/// @time   : 14:01:11

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueNotifier<int> index;

  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        iconTheme: WidgetStateProperty.all(
          const IconThemeData(color: Colors.black87),
        ),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 11.0,
          ),
        ),
      ),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (i) => index.value = i,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        indicatorColor: Colors.amber.shade200,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.house_outlined,
              color: Theme.of(context).primaryColor.withOpacity(.6),
            ),
            label: 'Home',
            selectedIcon: const Icon(Icons.house_rounded),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.category_outlined,
              color: Theme.of(context).primaryColor.withOpacity(.6),
            ),
            label: 'Category',
            selectedIcon: const Icon(Icons.category_rounded),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_outline_rounded,
              color: Theme.of(context).primaryColor.withOpacity(.6),
            ),
            label: 'Account',
            selectedIcon: const Icon(Icons.person_rounded),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Theme.of(context).primaryColor.withOpacity(.6),
            ),
            label: 'Cart',
            selectedIcon: const Icon(Icons.shopping_cart_rounded),
          ),
        ],
      ),
    );
  }
}
