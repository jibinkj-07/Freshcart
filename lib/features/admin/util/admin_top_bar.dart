import 'package:flutter/material.dart';

import 'utility_helper.dart';

class AdminTopBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;

  const AdminTopBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        UtilityHelper.getTitle(selectedIndex),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20.0,
        ),
      ),
      actions: selectedIndex == 0
          ? [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_rounded),
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
