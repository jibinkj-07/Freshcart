import 'package:flutter/material.dart';

import '../widget/custom_snackbar.dart';

class Failure {
  final String message;

  Failure({required this.message});

  void showSnackBar(BuildContext context) =>
      CustomSnackBar.showErrorSnackBar(context, message);
}
