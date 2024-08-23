import 'package:flutter/material.dart';

import '../../config/app_config.dart';

class CustomTextField extends StatelessWidget {
  final String textFieldKey;
  final bool isObscure;
  final bool? readOnly;
  final Widget? icon;
  final String hintText;
  final String? initialValue;
  final int? maxLines;
  final int? minLines;
  final TextInputAction inputAction;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.textFieldKey,
    required this.isObscure,
    this.icon,
    this.maxLines,
    required this.hintText,
    required this.inputAction,
    this.validator,
    this.onSaved,
    this.suffixIcon,
    this.inputType,
    required this.textCapitalization,
    this.onChanged,
    this.controller,
    this.initialValue,
    this.readOnly,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(key),
      controller: controller,
      readOnly: readOnly ?? false,
      obscureText: isObscure,
      textInputAction: inputAction,
      cursorColor: AppConfig.appColor,
      keyboardType: inputType,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      validator: validator,
      onSaved: onSaved,
      maxLines: maxLines,
      minLines: minLines,
      initialValue: initialValue,
      decoration: InputDecoration(
        prefixIcon: icon,
        prefixIconColor: WidgetStateColor.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.focused)) {
              return AppConfig.appColor;
            }
            return Colors.grey;
          },
        ),
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        contentPadding: const EdgeInsets.all(15.0),
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
