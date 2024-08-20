import 'package:flutter/material.dart';

import '../../config/config_helper.dart';

class OutlinedTextField extends StatelessWidget {
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

  const OutlinedTextField({
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
      cursorColor: ConfigHelper.appColor,
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
              return ConfigHelper.appColor;
            }
            return Colors.grey;
          },
        ),
        suffixIcon: suffixIcon,
        labelText: hintText,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        contentPadding: const EdgeInsets.all(15.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(width: 2, color: ConfigHelper.appColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 2, color: Colors.red),
        ),
      ),
    );
  }
}
