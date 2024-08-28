import 'package:flutter/material.dart';

import '../../config/app_config.dart';
import 'custom_text_field.dart';

class SearchField extends StatefulWidget {
  final ValueNotifier<String> query;
  final String? hintText;

  const SearchField({super.key, required this.query, this.hintText});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CustomTextField(
        controller: _textEditingController,
        textFieldKey: 'search',
        icon: Icon(Icons.search_rounded, color: Theme.of(context).primaryColor),
        isObscure: false,
        hintText: widget.hintText ?? 'Search',
        inputAction: TextInputAction.done,
        textCapitalization: TextCapitalization.none,
        onChanged: (value) => widget.query.value = value.toString().trim(),
        suffixIcon: ValueListenableBuilder(
          valueListenable: widget.query,
          builder: (ctx, q, child) =>
              q.isEmpty ? const SizedBox.shrink() : child!,
          child: IconButton(
            icon: const Icon(Icons.highlight_remove_rounded),
            style: IconButton.styleFrom(foregroundColor: AppConfig.appColor),
            onPressed: () {
              widget.query.value = '';
              _textEditingController.clear();
            },
          ),
        ),
      ),
    );
  }
}
