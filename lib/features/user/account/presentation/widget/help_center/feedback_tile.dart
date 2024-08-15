import 'package:flutter/material.dart';

import '../../../../../../core/config/route/route_mapper.dart';

/// @author : Jibin K John
/// @date   : 15/08/2024
/// @time   : 11:19:52


class FeedbackTile extends StatelessWidget {
const FeedbackTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(RouteMapper.feedbackScreen),
      leading: Icon(
        Icons.rate_review_outlined,
        color: Theme.of(context).primaryColor,
      ),
      title: const Text("Feedback"),
      // subtitle: const Text("App language preference"),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.grey,
        size: 15.0,
      ),
    );
  }
}

