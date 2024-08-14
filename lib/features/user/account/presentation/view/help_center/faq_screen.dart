import 'package:flutter/material.dart';

import '../../view_model/account_helper.dart';

/// @author : Jibin K John
/// @date   : 14/08/2024
/// @time   : 15:42:10

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Frequently Asked Questions",
          style: TextStyle(fontSize: 18.0),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: AccountHelper.faqMap.entries
            .map(
              (item) => ExpansionTile(
                backgroundColor: Theme.of(context).colorScheme.surface,
                childrenPadding: const EdgeInsets.all(10.0),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                title: Text(
                  item.key,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                children: [
                  Text(item.value),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
