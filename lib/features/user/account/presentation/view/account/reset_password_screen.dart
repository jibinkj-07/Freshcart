import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/mixin/validation_mixin.dart';
import '../../../../../../core/util/widget/animated_loading_button.dart';
import '../../../../../../core/util/widget/custom_text_field.dart';
import '../../widget/account_widget_helper.dart';

/// @author : Jibin K John
/// @date   : 15/08/2024
/// @time   : 16:08:23

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();

  // Notifiers
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  String _email = "";

  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: BlocListener<UserBloc, UserState>(
      //   listener: (ctx, state) {
      //     // Updating loading variable
      //     _loading.value = state.fetching;
      //
      //     // Checking for errors
      //     if (state.error != null) {
      //       state.error!.showSnackBar(context);
      //     }
      //   },
      //   child: Column(
      //     children: [
      //       AccountWidgetHelper.appIconBox(context),
      //       Expanded(
      //         child: ListView(
      //           padding: const EdgeInsets.symmetric(
      //             horizontal: 15.0,
      //             vertical: 10.0,
      //           ),
      //           children: [
      //             const Text(
      //               "Reset Password",
      //               style: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 20.0,
      //               ),
      //               textAlign: TextAlign.center,
      //             ),
      //             AccountWidgetHelper.spacer(height: 25.0),
      //             const Text(
      //               "Enter your registered email below to receive password reset instruction",
      //               textAlign: TextAlign.center,
      //             ),
      //
      //             AccountWidgetHelper.spacer(),
      //             // Email
      //             Form(
      //               key: _formKey,
      //               child: CustomTextField(
      //                 textFieldKey: 'email',
      //                 isObscure: false,
      //                 icon: const Icon(Icons.mail_rounded),
      //                 validator: validateEmail,
      //                 onSaved: (value) => _email = value.toString().trim(),
      //                 hintText: 'Email',
      //                 inputAction: TextInputAction.done,
      //                 inputType: TextInputType.emailAddress,
      //                 textCapitalization: TextCapitalization.none,
      //               ),
      //             ),
      //             AccountWidgetHelper.spacer(height: 40.0),
      //             Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 30.0),
      //               child: ValueListenableBuilder(
      //                 valueListenable: _loading,
      //                 builder: (ctx, loading, _) {
      //                   return AnimatedLoadingButton(
      //                     onPressed: loading ? null : _sendInstruction,
      //                     loading: loading,
      //                     child: const Text("Send Instruction"),
      //                   );
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Text("hey"),
    );
  }

  // Login Function
  void _sendInstruction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      // context.read<UserBloc>().add(ResetPassword(email: _email));
    }
  }
}
