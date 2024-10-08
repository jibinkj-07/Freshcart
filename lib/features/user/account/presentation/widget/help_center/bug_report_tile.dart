import 'package:flutter/material.dart';

import '../../../../../../core/config/route/route_mapper.dart';

/// @author : Jibin K John
/// @date   : 14/08/2024
/// @time   : 15:35:08

class BugReportTile extends StatelessWidget {
  const BugReportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(RouteMapper.bugReportScreen),
      leading: Icon(
        Icons.bug_report_outlined,
        color: Theme.of(context).primaryColor,
      ),
      title: const Text("Bug Report"),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.grey,
        size: 15.0,
      ),
    );
  }
}
