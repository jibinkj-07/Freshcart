import 'package:flutter/material.dart';
import '../widget/bug_report_tile.dart';
import '../widget/faq_tile.dart';
import '../widget/feedback_tile.dart';
import '../widget/lang_selector.dart';
import '../widget/theme_selector.dart';

/// @author : Jibin K John
/// @date   : 08/08/2024
/// @time   : 14:07:17

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _title("   App Settings"),
        const ThemeSelector(),
        const LangSelector(),
        _title("   Help Center"),
        const FAQTile(),
        const BugReportTile(),
        const FeedbackTile(),

      ],
    );
  }

  Widget _title(String title) => Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Text(title),
      );
}
