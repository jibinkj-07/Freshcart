import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/config/app_config.dart';
import '../../../../../../core/config/route/route_mapper.dart';
import '../../../../../../core/util/helper/asset_mapper.dart';
import '../../../../../common/presentation/bloc/account_bloc.dart';
import '../../../../../common/presentation/bloc/auth_bloc.dart';
import '../../widget/account_widget_helper.dart';

/// @author : Jibin K John
/// @date   : 15/08/2024
/// @time   : 16:00:53

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final bool fromProfile;

  const EmailVerificationScreen({
    super.key,
    required this.email,
    required this.fromProfile,
  });

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final ValueNotifier<bool> _verified = ValueNotifier(false);

  late Timer _timer;

  @override
  void initState() {
    final accountBloc = context.read<AccountBloc>();
    accountBloc.add(SendVerificationMail());
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      accountBloc.add(CheckEmailVerification());
    });
    super.initState();
  }

  @override
  void dispose() {
    _verified.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Preventing user to navigate back during verification process
    return PopScope(
      canPop: false,
      child: BlocListener<AccountBloc, AccountState>(
        listener: (ctx, state) {
          if (state.error != null) {
            state.error!.showSnackBar(context);
          }
          _verified.value = state.status == AccountStatus.emailVerified;
          if (state.status == AccountStatus.emailVerified) {
            _timer.cancel();
            Future.delayed(
              const Duration(seconds: 3),
              () {
                if (!mounted) return;
                final authBloc = context.read<AuthBloc>();
                if (widget.fromProfile || !authBloc.state.userInfo!.isAdmin) {
                  Navigator.pop(context);
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteMapper.adminHomeScreen,
                    (_) => false,
                  );
                }
              },
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false),
          body: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SvgPicture.asset(
                    AssetMapper.verifyEmailSVG,
                    height: MediaQuery.sizeOf(context).height * .3,
                  ),
                  AccountWidgetHelper.spacer(),
                  const Text(
                    "Verify your Email Address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  AccountWidgetHelper.spacer(height: 30.0),
                  ValueListenableBuilder(
                    valueListenable: _verified,
                    builder: (ctx, verified, child) {
                      return verified
                          ? const Text(
                              "Your email has been verified.\nThis screen will close automatically",
                              textAlign: TextAlign.center,
                            )
                          : child!;
                    },
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "We've sent a verification email to ",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: AppConfig.fontFamily,
                                ),
                              ),
                              TextSpan(
                                text: "\n${widget.email}\n\n",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    " Please check your inbox and click the link in the email to verify your account."
                                    " If you don't see the email,"
                                    " make sure to check your spam or junk folder",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: AppConfig.fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Didn\'t received email?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            TextButton(
                              child: const Text('Send Again'),
                              onPressed: () => context
                                  .read<AccountBloc>()
                                  .add(SendVerificationMail()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
