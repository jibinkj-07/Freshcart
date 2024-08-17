import 'package:flutter/material.dart';

import '../../../../../../core/config/route/route_mapper.dart';

/// @author : Jibin K John
/// @date   : 14/08/2024
/// @time   : 15:32:00

class FAQTile extends StatelessWidget {
  const FAQTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(RouteMapper.userFaqScreen),
      leading: Icon(
        Icons.help_outline,
        color: Theme.of(context).primaryColor,
      ),
      title: const Text("FAQ"),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.grey,
        size: 15.0,
      ),
    );
  }
}
