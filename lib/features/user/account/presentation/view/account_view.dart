import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/widget/animated_loading_button.dart';
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

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (ctx, authState) {
        return ListView(
          children: [
            if (authState.userInfo == null)
              const LoginSection()
            else
              AccountInfo(
                userInfo: authState.userInfo!,
                emailStatus: authState.emailStatus,
              ),
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
              const Divider(thickness: .2, height: 0),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                  vertical: 10.0,
                ),
                child: ValueListenableBuilder(
                  valueListenable: _loading,
                  builder: (ctx, loading, _) {
                    return AnimatedLoadingButton(
                      onPressed: loading
                          ? null
                          : () => context.read<AuthBloc>().add(SignOut()),
                      loading: loading,
                      child: const Text("Sign out"),
                    );
                  },
                ),
              )
            ],
          ],
        );
      },
      listener: (BuildContext context, AuthState state) {
        _loading.value = state.authStatus == AuthStatus.signingOut;
        if (state.error != null) {
          state.error!.showSnackBar(context);
        }
      },
    );
  }

  Widget _title(String title) => Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Text(title),
      );
}
