import 'package:flutter/material.dart';

import '../../../../../core/util/widget/custom_snackbar.dart';

/// @author : Jibin K John
/// @date   : 14/08/2024
/// @time   : 15:18:29

class LangSelector extends StatelessWidget {
  const LangSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=>CustomSnackBar.showInfoSnackBar(context,"Feature will coming soon"),
      leading: Icon(
        Icons.translate_rounded,
        color: Theme.of(context).primaryColor,
      ),
      title: const Text("Language"),
      subtitle: const Text("App language preference"),
      trailing: Text(
        "eng",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
