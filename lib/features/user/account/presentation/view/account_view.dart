import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/presentation/bloc/auth_bloc.dart';
import '../widget/account/account_info.dart';
import '../widget/account/login_section.dart';
import '../widget/help_center/bug_report_tile.dart';
import '../widget/help_center/faq_tile.dart';
import '../widget/help_center/feedback_tile.dart';
import '../widget/settings/lang_selector.dart';
import '../widget/settings/theme_selector.dart';

/// @author : Jibin K John
/// @date   : 08/08/2024
/// @time   : 14:07:17

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (ctx, authState) {
      return ListView(
        children: [
          if (authState.userInfo == null)
            const LoginSection()
          else
            const AccountInfo(),
          _title("   App Settings"),
          const ThemeSelector(),
          const LangSelector(),
          _title("   Help Center"),
          const FAQTile(),
          // Showing bug and feedback section only
          // if user is authenticated
          if (authState.userInfo != null) ...[
            const BugReportTile(),
            const FeedbackTile(),
          ],
        ],
      );
    });
  }

  Widget _title(String title) => Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Text(title),
      );
}
