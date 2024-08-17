import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/config/route/route_mapper.dart';
import '../../../../../../core/util/helper/asset_mapper.dart';
import '../../../../../../core/util/mixin/validation_mixin.dart';
import '../../../../../../core/util/widget/animated_loading_button.dart';
import '../../../../../../core/util/widget/custom_text_field.dart';
import '../../../../../common/presentation/bloc/account_bloc.dart';
import '../../widget/account_widget_helper.dart';

/// @author : Jibin K John
/// @date   : 15/08/2024
/// @time   : 12:06:22

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();

  // Notifiers
  final ValueNotifier<bool> _isObscure = ValueNotifier(true);
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  String _email = "";
  String _name = "";
  String _password = "";

  @override
  void dispose() {
    _isObscure.dispose();
    _loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AccountBloc, AccountState>(
        listener: (ctx, state) {
          // Updating loading variable
          _loading.value = state.status == AccountStatus.creatingAccount;

          // Routing user to email verification screen
          if (state.status == AccountStatus.accountCreated) {
            Navigator.of(context).pushReplacementNamed(
              RouteMapper.emailVerificationScreen,
            );
          }

          // Checking for errors
          if (state.error != null) {
            state.error!.showSnackBar(context);
          }
        },
        child: Column(
          children: [
            AccountWidgetHelper.appIconBox(context),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  children: [
                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    AccountWidgetHelper.spacer(height: 25.0),
                    // Email
                    CustomTextField(
                      textFieldKey: 'email',
                      isObscure: false,
                      icon: const Icon(Icons.mail_rounded),
                      validator: validateEmail,
                      onSaved: (value) => _email = value.toString().trim(),
                      hintText: 'Email',
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                    ),
                    AccountWidgetHelper.spacer(),

                    // Name
                    CustomTextField(
                      textFieldKey: 'name',
                      isObscure: false,
                      icon: const Icon(Icons.person_rounded),
                      validator: validateUsername,
                      onSaved: (value) => _name = value.toString().trim(),
                      hintText: 'Name',
                      inputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                    ),
                    AccountWidgetHelper.spacer(),

                    // Password
                    ValueListenableBuilder<bool>(
                      valueListenable: _isObscure,
                      builder: (ctx, obscure, Widget? child) {
                        return CustomTextField(
                          textFieldKey: 'password',
                          isObscure: obscure,
                          maxLines: 1,
                          icon: const Icon(Icons.lock),
                          validator: validatePassword,
                          onSaved: (value) =>
                              _password = value.toString().trim(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscure
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _isObscure.value = !_isObscure.value;
                            },
                          ),
                          hintText: 'Password',
                          inputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.none,
                        );
                      },
                    ),
                    AccountWidgetHelper.spacer(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ValueListenableBuilder(
                        valueListenable: _loading,
                        builder: (ctx, loading, _) {
                          return AnimatedLoadingButton(
                            onPressed: loading ? null : _loginUser,
                            loading: loading,
                            child: const Text("Create"),
                          );
                        },
                      ),
                    ),

                    const Divider(
                      indent: 30.0,
                      endIndent: 30.0,
                      thickness: .5,
                    ),
                    const Center(child: Text("Continue with")),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50.0,
                        vertical: 10.0,
                      ),
                      child: FilledButton.icon(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          foregroundColor: Theme.of(context).primaryColor,
                        ),
                        icon: SvgPicture.asset(
                          AssetMapper.googleSVG,
                          width: 25.0,
                          height: 25.0,
                        ),
                        label: const Text("Google"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                    RouteMapper.loginScreen,
                  ),
                  child: const Text("Sign in"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
//
  // Login Function
  void _loginUser() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      context.read<AccountBloc>().add(
            CreateAccount(name: _name, email: _email, password: _password),
          );
    }
  }
}
