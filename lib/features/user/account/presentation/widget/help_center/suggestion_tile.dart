import 'package:flutter/material.dart';

import '../../../../../../core/config/route/route_mapper.dart';

/// @author : Jibin K John
/// @date   : 15/08/2024
/// @time   : 19:21:11

class SuggestionTile extends StatelessWidget {
  const SuggestionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(RouteMapper.feedbackScreen),
      leading: Icon(
        Icons.auto_awesome_outlined,
        color: Theme.of(context).primaryColor,
      ),
      title: const Text("Suggestion"),
      subtitle: const Text("Add suggestions to enhance your experience"),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.grey,
        size: 15.0,
      ),
    );
  }
}
